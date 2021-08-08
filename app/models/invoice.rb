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
    .select('items.name, invoice_items.quantity, invoice_items.unit_price, invoice_items.discount, items.merchant_id, invoice_items.status as order_status')
  end

  def total_revenue(merchant_id)
    merchant_items(merchant_id)
    .sum('invoice_items.quantity * invoice_items.unit_price') / 100.00
  end

  def total_discount(merchant_id)
    merchant = Merchant.find(merchant_id)
    total_revenue(merchant_id) *
    merchant.discounts
    .joins(merchant: [{items: :invoice_items}])
    .where('discounts.quantity_threshold >= invoice_items.quantity')
  end

  def apply_item_discount(merchant_id)
    merchant = Merchant.find(merchant_id)
    merchant_items(merchant_id).each do |item|
      if merchant.discounts.where('discounts.quantity_threshold <= ?', item.quantity).empty?
        item.update!(discount: 0)
      else
        item.update!(discount: calculate_discount(merchant, item))
        require "pry"; binding.pry
      end
    end
  end

  def calculate_discount(merchant, item)
    (merchant.discounts
    .where('discounts.quantity_threshold <= ?', item.quantity)
    .order('discounts.percent desc')
    .limit(1)
    .pluck('discounts.percent').first * (item.quantity * item.unit_price)) / 100
  end

  def discounted_revenue(merchant_id)
    merchant_items(merchant_id)
    .sum('quantity * items.unit_price') / 100.00
  end

  def total_invoice_revenue
    invoice_items.sum('invoice_items.unit_price * invoice_items.quantity') / 100.00
  end
end
