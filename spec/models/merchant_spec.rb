require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Tillman Group')
    @merchant_2 = Merchant.create!(name: 'Kozy Group')
    @merchant_3 = Merchant.create!(name: 'K Group')
    @merchant_4 = Merchant.create!(name: 'O Group')
    @merchant_5 = Merchant.create!(name: 'Z Group')
    @merchant_6 = Merchant.create!(name: 'Y Group')

    @customer1 = Customer.create!(first_name: 'Petey', last_name: 'Wimbley')

    @item1 = @merchant_1.items.create!(name: 'Teddy Bear', description: 'So fuzzy', unit_price: 2000)
    @item2 = @merchant_1.items.create!(name: 'Toy Car', description: 'So fast', unit_price: 3000)
    @item3 = @merchant_1.items.create!(name: 'Bouncy Ball', description: 'So bouncy', unit_price: 500)
    @item4 = @merchant_2.items.create!(name: 'Dog Bone', description: 'So chewy', unit_price: 800)
    @item5 = @merchant1.items.create!(name: 'Twist Tie', description: 'So twisty', unit_price: 100)
    @item6 = @merchant1.items.create!(name: 'Snake-on-a-Rope', description: 'So squiggly', unit_price: 500)
    @item7 = @merchant1.items.create!(name: 'Chonky Rat', description: 'So chonky', unit_price: 1000)
    @item_1 = @merchant_2.items.create!(name: 'item 1', description: 'item', unit_price: 1000)
    @item_2 = @merchant_3.items.create!(name: 'item 1', description: 'item', unit_price: 1000)
    @item_3 = @merchant_4.items.create!(name: 'item 1', description: 'item', unit_price: 1000)
    @item_4 = @merchant_5.items.create!(name: 'item 1', description: 'item', unit_price: 1000)
    @item_5 = @merchant_6.items.create!(name: 'item 1', description: 'item', unit_price: 1000)
    @item_6 = @merchant_1.items.create!(name: 'item 1', description: 'item', unit_price: 1000)

    @invoice1 = @customer1.invoices.create!(status: 0)
    @invoice_2 = Invoice.create!(status: 1, customer_id: "#{@customer1.id}", created_at: "Wednesday, August 04, 2021")
    @invoice_3 = Invoice.create!(status: 0, customer_id: "#{@customer1.id}", created_at: "Thursday, August 05, 2021")
    @invoice_4 = Invoice.create!(status: 0, customer_id: "#{@customer1.id}", created_at: "Friday, August 06, 2021")
    @invoice_5 = Invoice.create!(status: 0, customer_id: "#{@customer1.id}", created_at: "Saturday, August 07, 2021")
    @invoice_6 = Invoice.create!(status: 0, customer: @customer1)

    @transaction1 = @invoice1.transactions.create!(credit_card_number: "0123456789", credit_card_expiration_date: '12/31', result: 0)
    @transaction2 = @invoice_2.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @transaction3 = @invoice_3.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @transaction4 = @invoice_4.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @transaction5 = @invoice_5.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @transaction6 = @invoice_6.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'failed')

    @ii1 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, quantity: 2, status: 0)
    @ii2 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item2.id, quantity: 1, status: 0)
    @ii3 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item4.id, quantity: 1, status: 0)
    @ii4 = InvoiceItem.create!(invoice: @invoice_2, item: @item_2, quantity: 4, unit_price: 1000, status: 0)
    @ii5 = InvoiceItem.create!(invoice: @invoice_3, item: @item_3, quantity: 3, unit_price: 1000, status: 1)
    @ii6 = InvoiceItem.create!(invoice: @invoice_4, item: @item_4, quantity: 2, unit_price: 1000, status: 0)
    @ii7 = InvoiceItem.create!(invoice: @invoice_5, item: @item_5, quantity: 1, unit_price: 1000, status: 2)
    @ii8 = InvoiceItem.create!(invoice: @invoice_6, item: @item_6, quantity: 5, unit_price: 1000, status: 2)
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
        @merchant_2.enable

        expect(Merchant.group_by_disabled).to eq([@merchant_3, @merchant_4, @merchant_5, @merchant_6])
      end

    describe '::top_five_by_revenue' do
      it 'can determine the top five merchants by total revenue' do
        expect(Merchant.top_five_by_revenue).to eq([@merchant_2, @merchant_1, @merchant_3, @merchant_4, @merchant_5])
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
        expect(@merchant_1.items_on_invoice(@invoice1.id).first.name).to eq(@item1.name)
        expect(@merchant_1.items_on_invoice(@invoice1.id).last.name).to eq(@item2.name)
        expect(@merchant_1.items_on_invoice(@invoice1.id).length).to eq(2)
      end
    end

    describe '#top_sale_date_for_merchant' do
      it 'can determine the top sales date for a merchant' do
        expect(@merchant_1.top_sale_date_for_merchant.created_at.strftime("%A, %B %d, %Y")).to eq("Tuesday, August 03, 2021")
      end
    end

    describe '#top_5_items' do
      it 'can display the top 5 items for a merchant' do

      end
    end

  end
end
end
