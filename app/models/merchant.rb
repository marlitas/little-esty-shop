class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def enable
    self.update(status: true)
  end

  def disable
    self.update(status: false)
  end

  def self.group_by_enabled
    Merchant.where('status = ?', true)
  end

  def self.group_by_disabled
    Merchant.where('status = ?', false)
  end

  def self.top_five_by_revenue
    Merchant.joins(items: :invoices).joins(invoices: :transactions)
    .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price)/100 as total_revenue')
    .group(:id)
    .where('transactions.result = 0')
    .order('total_revenue desc')
    .limit(5)
  end

  def top_sale_date_for_merchant
    invoices.joins(:transactions)
    .select('SUM(invoice_items.quantity * invoice_items.unit_price)/100 as total_revenue, invoices.created_at')
    .where('transactions.result = 0')
    .group('invoices.created_at')
    .order('total_revenue desc')
    .first
  end

  def items_on_invoice(id)
    invoice_items.select('items.name, items.unit_price as item_price, invoice_items.*').where('invoice_id = ?', id)
  end
end
