class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: [:pending, :packaged, :shipped]


  def unit_price_to_dollars
    self.unit_price / 100.00
  end

  # def price_to_dollars(unit_price)
  #   (unit_price / 100.00).round(2)
  # end
end
