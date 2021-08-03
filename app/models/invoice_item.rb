class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: [:pending, :packaged, :shipped]

  def unit_price_to_dollars
    self.unit_price / 100.00
  end
end
