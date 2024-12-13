require "test_helper"

class ProductosControllerTest < ActionDispatch::IntegrationTest

  def setup
    login
  end
  test 'rederizar lista de productos' do
    get productos_path
    assert_response :success
    assert_select '.Producto', count: 10
  end

  test 'actualizar producto' do
    patch producto_path(productos(:queso_maduro)), params: {
      producto: {
        price: 22
      }
    }

    assert_redirected_to producto_path
    assert_equal flash[:notice], 'El producto ha sido actualizado correctamente'
  end

  test 'eliminar un producto' do
    assert_difference('Producto.count', -1) do
      delete producto_path(productos(:cafe_de_altura))
    end

    assert_redirected_to productos_path
    assert_equal flash[:notice], 'Producto eliminado con èxito'
  end
end
