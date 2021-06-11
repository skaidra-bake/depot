class Product < ApplicationRecord
  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validates :title, length: {
    minimum: 10,
    message: 'is too short. Go above 10 characters!'
  }
  validates :image_url, format: {
    with:     %r{\.(gif|jpg|png)\Z}i,
    message:  'must be a URL for GIF, JPG or PNG image.'
  }, allow_blank: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
end
