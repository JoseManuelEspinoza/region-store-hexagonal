class Region < ApplicationRecord
  has_many :productos, dependent: :restrict_with_exception
end
