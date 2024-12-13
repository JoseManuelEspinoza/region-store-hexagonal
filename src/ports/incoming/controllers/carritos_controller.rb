class CarritosController < ApplicationController
    skip_before_action :protect_pages_admin
    before_action :protect_pages_login

    def index
      @carritos = Current.user.carritos.includes(:producto)
    end

    def create
      begin
        Carrito.create!(producto: producto, user: Current.user)
        redirect_to productos_path, notice: "Producto añadido al carrito"
      rescue ActiveRecord::RecordNotUnique
        redirect_to productos_path, alert: "¡El producto ya está en tu carrito!"
      rescue => e
        redirect_to productos_path, alert: "Hubo un error al añadir el producto al carrito: #{e.message}"
      end
    end

    def destroy
        @carrito = Carrito.find_by(params[:id])
        if @carrito
          @carrito.destroy
          redirect_to carritos_path, notice: "Producto eliminado del carrito exitosamente."
        else
          redirect_to carritos_path, alert: "El producto no existe en tu carrito."
        end
      end


    private

    def carrito
        @carrito = Carrito.find(params[:id])
      end
    def producto
        @producto ||= Producto.find(params[:producto_id])
    end
end
