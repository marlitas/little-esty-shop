class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: [:cancelled, 'in progress', :completed]

  def self.admin_incomplete_invoices
    Invoice.select('invoices.*, invoice_items.invoice_id as number')
    .joins(:invoice_items)
    .where('invoice_items.status != 2')
    .order(:created_at)
    .distinct
  end

  def self.merchant_invoices(id)
    joins(:items)
    .select('invoices.*')
    .where('merchant_id = ?', id).distinct
  end

  def merchant_items(id)
    items.where('merchant_id = ?', id)
    .select('items.name, invoice_items.id, invoice_items.quantity, invoice_items.unit_price, invoice_items.discount, items.merchant_id, invoice_items.status as order_status')
  end

  def total_revenue(merchant_id)
    merchant_items(merchant_id)
    .sum('invoice_items.quantity * invoice_items.unit_price') / 100.00
  end

  def total_discount(merchant_id)
    apply_item_discount
    invoice_items
    .joins(:item)
    .where('items.merchant_id = ?', merchant_id)
    .sum('invoice_items.discount') / 100.00
  end

  def choose_discount(merchant, item)
    merchant.discounts
    .where('discounts.quantity_threshold <= ?', item.quantity)
    .order('discounts.percent desc')
    .limit(1).first
  end

  def calculate_discount(merchant, item)
    choose_discount(merchant, item)
    .percent * (item.quantity * item.unit_price) / 100
  end

  def discounted_revenue(merchant_id)
    self.total_revenue(merchant_id) - self.total_discount(merchant_id)
  end

  def apply_item_discount
    invoice_items.each do |ii|
      item = Item.find(ii.item_id)
      merchant = Merchant.find(item.merchant_id)
      if self.choose_discount(merchant, ii).nil?
        ii.update!(discount: 0)
      else
        ii.update!(discount: calculate_discount(merchant, ii), discount_id: choose_discount(merchant, ii).id)
      end
    end
  end

  def total_invoice_discount
    self.apply_item_discount
    self.invoice_items
    .sum('invoice_items.discount') / 100.00
  end

  def total_discounted_revenue
    self.total_invoice_revenue - self.total_invoice_discount
  end

  def total_invoice_revenue
    invoice_items.sum('invoice_items.unit_price * invoice_items.quantity') / 100.00
  end
end
