class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  enum status: [:enabled, :disabled]

  def self.ready_to_ship(merchant_id)
    select('items.id, name, invoices.id as invoice_id, invoices.created_at')
    .joins(:invoices)
    .where('items.merchant_id = ?', merchant_id)
    .where('invoice_items.status = 1')
    .order('invoices.created_at')
  end

  def price_to_dollars
    (unit_price / 100.00).round(2)
  end

  def self.enabled
    where('status = ?', 0)
  end

  def self.disabled
    where('status = ?', 1)
  end


  def best_day
    invoices.joins(:transactions)
    .select('invoices.created_at, SUM(invoice_items.quantity * invoice_items.unit_price) as total')
    .where('transactions.result = 0')
    .group('invoices.created_at')
    .order('total desc').first.created_at
  end 
  
  def self.top_5_items
    Item.joins(invoices: :transactions)
    .select('items.id, items.name, SUM(invoice_items.quantity * invoice_items.unit_price) as total')
    .where('transactions.result = 0')
    .group('items.id')
    .order('total desc')
    .limit(5)
  end
end
