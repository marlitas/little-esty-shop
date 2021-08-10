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
    it 'can manipulate price to dollars' do
      merchant_1 = Merchant.create!(name: 'The Wand Shop')
      item = merchant_1.items.create!(name: 'Horse Feather Oak', description: 'So magical', unit_price: 20000)
      customer = Customer.create!(first_name: 'Harry', last_name: 'Potter')
      invoice = Invoice.create!(customer_id: customer.id, status: 0)
      ii = InvoiceItem.create!(item_id: item.id, invoice_id: invoice.id, status: 1, unit_price: 20000, quantity: 1)

      expect(ii.unit_price_to_dollars).to eq(200.00)
    end
  end
end
