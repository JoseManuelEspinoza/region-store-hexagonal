class Producto < ApplicationRecord

  ORDER_BY = {
    newest: "created_at DESC",
    expensive: "price DESC",
    cheapest: "price ASC"
  }

  has_one_attached :photo
  validates :titulo, presence: true
  validates :description, presence: true
  validates :price, presence: true

  belongs_to :region
end
