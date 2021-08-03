require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it {should belong_to :item}
    it {should belong_to :invoice}
  end

  describe 'validations' do
    it {should define_enum_for(:status).with_values([:pending, :packaged, :shipped])}
  end

  describe 'instance methods' do
    it 'can transform unit price to dollars' do
      merchant1 = Merchant.create!(name: 'Sparkys Shop')
      item = merchant1.items.create!(name: 'Teddy Bear', description: 'So fuzzy', unit_price: 2050)
      customer = Customer.create!(first_name: 'Sally', last_name: 'Sal')
      invoice = Invoice.create!(customer_id: customer.id, status: 0)
      ii = InvoiceItem.create!(item_id: item.id, invoice_id: invoice.id, status: 1, unit_price: 2080, quantity: 1)

      expect(ii.price_to_dollars).to eq(20.80)
    end
  end
end
