require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Tillman Group')
    @merchant_2 = Merchant.create!(name: 'Kozy Group')

    @customer1 = Customer.create!(first_name: 'Petey', last_name: 'Wimbley')

    @item1 = @merchant_1.items.create!(name: 'Teddy Bear', description: 'So fuzzy', unit_price: 2000)
    @item2 = @merchant_1.items.create!(name: 'Toy Car', description: 'So fast', unit_price: 3000)
    @item3 = @merchant_1.items.create!(name: 'Bouncy Ball', description: 'So bouncy', unit_price: 500)
    @item4 = @merchant_2.items.create!(name: 'Dog Bone', description: 'So chewy', unit_price: 800)

    @invoice1 = @customer1.invoices.create!(status: 0)

    @transaction1 = @invoice1.transactions.create!(credit_card_number: "0123456789", credit_card_expiration_date: '12/31', result: 0)

    @ii1 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, quantity: 2, status: 0)
    @ii2 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item2.id, quantity: 1, status: 0)
    @ii3 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item4.id, quantity: 1, status: 0)
  end

  describe 'relationships' do
    it {should have_many :items}
  end

  describe 'class methods' do
    describe '::group_by_enabled' do
      it 'can group merchants by enabled status(true)' do
        @merchant_1.enable

        expect(Merchant.group_by_enabled).to eq([@merchant_1])
      end
    end

    describe '::group_by_disabled' do
      it 'can group merchants by disabled status(true)' do
        @merchant_1.enable

        expect(Merchant.group_by_disabled).to eq([@merchant_2])
      end
    end
  end

  describe 'instance methods' do
    describe '#enable' do
      it 'can update status to true(enabled)' do
        @merchant_1.enable
        expect(@merchant_1.status).to eq(true)
      end
    end

    describe '#disable' do
      it 'can update status to false(disabled)' do
        @merchant_1.disable
        expect(@merchant_1.status).to eq(false)
      end
    end

    describe '#invoice_items' do
      it 'can retrieve invoice items' do
        expect(@merchant_1.items_on_invoice(@invoice1.id).first.name).to eq(@item1.name)
        expect(@merchant_1.items_on_invoice(@invoice1.id).last.name).to eq(@item2.name)
        expect(@merchant_1.items_on_invoice(@invoice1.id).length).to eq(2)
      end
    end
  end
end
