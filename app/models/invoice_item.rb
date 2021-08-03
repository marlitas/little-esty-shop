class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  # enum status: [:pending, :packaged, :shipped]
  enum status: {pending: 0, packaged: 1, shipped: 2}

  def price_to_dollars
    (unit_price / 100.00).round(2)
  end
end
