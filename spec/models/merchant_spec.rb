require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Tillman Group')
    @merchant_2 = Merchant.create!(name: 'Kozy Group')
    @merchant_3 = Merchant.create!(name: 'K Group')
    @merchant_4 = Merchant.create!(name: 'O Group')
    @merchant_5 = Merchant.create!(name: 'Z Group')
    @merchant_6 = Merchant.create!(name: 'Y Group')

    @customer_1 = Customer.create!(first_name: 'Petey', last_name: 'Wimbley')

    @item_1 = @merchant_1.items.create!(name: 'Teddy Bear', description: 'So fuzzy', unit_price: 2000)
    @item_2 = @merchant_1.items.create!(name: 'Toy Car', description: 'So fast', unit_price: 3000)
    @item_3 = @merchant_1.items.create!(name: 'Bouncy Ball', description: 'So bouncy', unit_price: 500)
    @item_4 = @merchant_2.items.create!(name: 'Dog Bone', description: 'So chewy', unit_price: 800)
    @item_5 = @merchant_2.items.create!(name: 'item 1', description: 'item', unit_price: 1000)
    @item_6 = @merchant_3.items.create!(name: 'item 2', description: 'item', unit_price: 1000)
    @item_7 = @merchant_4.items.create!(name: 'item 3', description: 'item', unit_price: 1000)
    @item_8 = @merchant_5.items.create!(name: 'item 4', description: 'item', unit_price: 1000)
    @item_9 = @merchant_6.items.create!(name: 'item 5', description: 'item', unit_price: 1000)
    @item_10 = @merchant_1.items.create!(name: 'item 6', description: 'item', unit_price: 1000)
    @item_11 = @merchant_1.items.create!(name: 'item 11', description: 'item', unit_price: 1000)
    @item_12 = @merchant_1.items.create!(name: 'item 12', description: 'item', unit_price: 1000)
    @item_13 = @merchant_1.items.create!(name: 'item 13', description: 'item', unit_price: 1000)
    @item_14 = @merchant_1.items.create!(name: 'item 14', description: 'item', unit_price: 1000)

    @invoice_1 = Invoice.create!(status: 0, customer: @customer_1, created_at: "Tuesday, August 03, 2021")
    @invoice_2 = Invoice.create!(status: 1, customer: @customer_1, created_at: "Wednesday, August 04, 2021")
    @invoice_3 = Invoice.create!(status: 0, customer: @customer_1, created_at: "Thursday, August 05, 2021")
    @invoice_4 = Invoice.create!(status: 0, customer: @customer_1, created_at: "Friday, August 06, 2021")
    @invoice_5 = Invoice.create!(status: 0, customer: @customer_1, created_at: "Saturday, August 07, 2021")
    @invoice_6 = Invoice.create!(status: 0, customer: @customer_1, created_at: "Sunday, August 08, 2021")
    @invoice_7 = Invoice.create!(status: 0, customer: @customer_1, created_at: "Monday, August 09, 2021")
    @invoice_8 = Invoice.create!(status: 0, customer: @customer_1, created_at: "Tuesday, August 10, 2021")
    @invoice_9 = Invoice.create!(status: 0, customer: @customer_1, created_at: "Wednesday, August 11, 2021")
    @invoice_10 = Invoice.create!(status: 0, customer: @customer_1, created_at: "Thursday, August 12, 2021")

    @transaction_1 = @invoice_1.transactions.create!(credit_card_number: "0123456789", credit_card_expiration_date: '12/31', result: 0)
    @transaction_2 = @invoice_2.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @transaction_3 = @invoice_3.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @transaction_4 = @invoice_4.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @transaction_5 = @invoice_5.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @transaction_6 = @invoice_6.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'failed')
    @transaction_7 = @invoice_7.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @transaction_8 = @invoice_8.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @transaction_9 = @invoice_9.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @transaction_10 = @invoice_10.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')

    @ii_1 = InvoiceItem.create!(invoice: @invoice_1, item: @item_1, quantity: 2, unit_price: 2000, status: 0)
    @ii_2 = InvoiceItem.create!(invoice: @invoice_1, item: @item_2, quantity: 1, unit_price: 3000, status: 0)
    @ii_3 = InvoiceItem.create!(invoice: @invoice_1, item: @item_4, quantity: 1, unit_price: 1000, status: 0)
    @ii_4 = InvoiceItem.create!(invoice: @invoice_2, item: @item_6, quantity: 4, unit_price: 1000, status: 0)
    @ii_5 = InvoiceItem.create!(invoice: @invoice_3, item: @item_7, quantity: 3, unit_price: 1000, status: 1)
    @ii_6 = InvoiceItem.create!(invoice: @invoice_4, item: @item_8, quantity: 2, unit_price: 1000, status: 0)
    @ii_7 = InvoiceItem.create!(invoice: @invoice_5, item: @item_9, quantity: 1, unit_price: 1000, status: 2)
    @ii_8 = InvoiceItem.create!(invoice: @invoice_6, item: @item_10, quantity: 5, unit_price: 1000, status: 2)
    @ii_9 = InvoiceItem.create!(invoice: @invoice_7, item: @item_11, quantity: 4, unit_price: 1000, status: 2)
    @ii_10 = InvoiceItem.create!(invoice: @invoice_8, item: @item_12, quantity: 3, unit_price: 1000, status: 2)
    @ii_11 = InvoiceItem.create!(invoice: @invoice_9, item: @item_13, quantity: 2, unit_price: 1000, status: 2)
    @ii_12 = InvoiceItem.create!(invoice: @invoice_10, item: @item_14, quantity: 6, unit_price: 1000, status: 2)

  end

  describe 'relationships' do
    it {should have_many :items}
    it {should have_many :discounts}
    it {should have_many(:invoice_items).through(:items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:transactions).through(:invoices)}
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
        @merchant_2.enable

        expect(Merchant.group_by_disabled).to eq([@merchant_3, @merchant_4, @merchant_5, @merchant_6])
      end

    describe '::top_five_by_revenue' do
      it 'can determine the top five merchants by total revenue' do
        expect(Merchant.top_five_by_revenue).to eq([@merchant_1, @merchant_3, @merchant_4, @merchant_5, @merchant_2])
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

    describe '#items_on_invoice' do
      it 'can retrieve invoice items' do
        expect(@merchant_1.items_on_invoice(@invoice_1.id).first.name).to eq(@item_1.name)
        expect(@merchant_1.items_on_invoice(@invoice_1.id).last.name).to eq(@item_2.name)
        expect(@merchant_1.items_on_invoice(@invoice_1.id).length).to eq(2)
      end
    end

    describe '#top_sale_date_for_merchant' do
      it 'can determine the top sales date for a merchant' do
        expect(@merchant_1.top_sale_date_for_merchant.created_at.strftime("%A, %B %d, %Y")).to eq("Tuesday, August 03, 2021")
      end
    end

    describe '#top_5_items' do
      it 'can display the top 5 items for a merchant' do
        expect(@merchant_1.items.top_5_items).to eq([@item_14, @item_1, @item_11, @item_2, @item_12])
      end
    end
  end
end
end
