class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: [:pending, :packaged, :shipped]
  
  def price_to_dollars
    (unit_price / 100.00).round(2)
  end
end
