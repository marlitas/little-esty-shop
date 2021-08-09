require 'rails_helper'

RSpec.describe 'Merchant Invoices Index Page' do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    @discount1 = create(:discount_low, merchant_id: @merchant1.id)
    @discount2 = create(:discount_medium, merchant_id: @merchant1.id)
    @discount3 = create(:discount, merchant_id: @merchant2.id)

    @customer1 = create(:customer)

    @item1 = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)
    @item3 = create(:item_low, merchant_id: @merchant1.id)
    @item4 = create(:item, merchant_id: @merchant2.id)

    @invoice1 = create(:cancelled_invoice, customer_id: @customer1.id)
    @invoice2 = create(:invoice, customer_id: @customer1.id)
    @invoice3 = create(:invoice, customer_id: @customer1.id)
    @invoice4 = create(:invoice, customer_id: @customer1.id)

    @transaction1 = create(:transaction, invoice_id: @invoice1.id)
    @transaction2 = create(:failed_transaction, invoice_id: @invoice1.id)

    @ii1 = create(:invoice_item_low, invoice_id: @invoice1.id, item_id: @item1.id)
    @ii2 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item2.id)
    @ii3 = create(:invoice_item_high, invoice_id: @invoice2.id, item_id: @item3.id)
    @ii4 = create(:invoice_item_medium, invoice_id: @invoice1.id, item_id: @item4.id)
    @ii5 = create(:invoice_item_medium, invoice_id: @invoice2.id, item_id: @item1.id)
    @ii6 = create(:invoice_item_medium, invoice_id: @invoice3.id, item_id: @item1.id)
    @ii7 = create(:invoice_item_medium, invoice_id: @invoice4.id, item_id: @item4.id)
  end

  describe 'merchant' do
    it 'displays all invoices with at least one merchant item' do
      visit "/merchants/#{@merchant1.id}/invoices"

      expect(page).to have_content(@invoice1.id.to_s)
      expect(page).to have_content(@invoice2.id.to_s)
      expect(page).to have_content(@invoice3.id.to_s)

      expect(page).to_not have_content(@invoice4.id.to_s)
    end

    it 'can link an invoice to its show page' do
      visit "/merchants/#{@merchant1.id}/invoices"

      click_on(@invoice1.id.to_s)

      expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")
    end
  end
end
