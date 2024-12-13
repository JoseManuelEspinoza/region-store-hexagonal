class CreateProductos < ActiveRecord::Migration[7.1]
  def change
    create_table :productos do |t|
      t.string :titulo
      t.text :description
      t.float :price

      t.timestamps
    end
  end
end
