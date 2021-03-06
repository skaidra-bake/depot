class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.update(
        quantity: current_item.quantity += 1,
        price: current_item.price + product.price
      )
      current_item
    else
      current_item = line_items.build(product_id: product.id, price: product.price)
    end
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end
