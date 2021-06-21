class Product < ApplicationRecord
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

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

  private
    #ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, 'Line Items present')
        throw :abort
      end
    end
end
