class ProductosController < ApplicationController
  skip_before_action :protect_pages_admin, only: [:index, :show]

  def index
    @pagy, @productos = pagy(FindProductos.new.call(producto_prams_index), items: 10)
    @regions = Region.order(name: :asc)

    if params[:region_id]
      @productos = @productos.where(region_id: params[:region_id])
    end

    order_by = Producto::ORDER_BY.fetch(params[:order_by]&.to_sym, Producto::ORDER_BY[:newest])
    @productos = @productos.order(order_by)
  end

  def new
    authorize!
    @producto = Producto.new
  end

  def create
    authorize!
    @producto = Producto.new(producto_params)

    if @producto.save
      redirect_to productos_path, notice: "El producto ha sido creado correctamente"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    producto
  end

  def edit
    authorize!
    producto
  end

  def update
    authorize!
    producto
    if @producto.update(producto_params)
      redirect_to producto_path(@producto), notice: "El producto ha sido actualizado correctamente"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    producto
    if @producto
      Carrito.where(producto_id: @producto.id).destroy_all
      @producto.destroy
      redirect_to productos_path, notice: "Producto eliminado con éxito", status: :see_other
    else
      redirect_to productos_path, alert: "El producto no existe"
    end
  end

  def add_to_cart
    if current_user
      product = Producto.find(params[:id])
      current_user.cart_items.create(producto: product, quantity: 1)
      redirect_to productos_path, notice: 'Producto añadido al carrito'
    else
      redirect_to login_path, alert: 'Debes iniciar sesión para añadir productos al carrito'
    end
  end

  private

  def producto_params
    params.require(:producto).permit(:titulo, :description, :price, :photo, :region_id)
  end

  def producto_prams_index
    params.permit(:region_id, :order_by, :page)
  end

  def producto
    @producto ||= Producto.find(params[:id])
  end
end
