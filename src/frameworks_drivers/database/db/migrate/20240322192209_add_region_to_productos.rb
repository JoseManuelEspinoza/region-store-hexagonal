class AddRegionToProductos < ActiveRecord::Migration[7.1]
  def change
    add_reference :productos, :region, null: false, foreign_key: true
  end
end
