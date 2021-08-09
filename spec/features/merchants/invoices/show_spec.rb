require 'rails_helper'

RSpec.describe 'Invoice show page' do
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

    @transaction1 = create(:transaction, invoice_id: @invoice1.id)
    @transaction2 = create(:failed_transaction, invoice_id: @invoice1.id)

    @ii1 = create(:invoice_item_low, invoice_id: @invoice1.id, item_id: @item1.id)
    @ii2 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item2.id)
    @ii3 = create(:invoice_item_high, invoice_id: @invoice2.id, item_id: @item3.id)
    @ii4 = create(:invoice_item_medium, invoice_id: @invoice1.id, item_id: @item4.id)
    @ii5 = create(:invoice_item_medium, invoice_id: @invoice2.id, item_id: @item1.id)
  end

  describe 'merchant' do
    it 'displays invoice attributes' do
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content(@invoice1.status)
      expect(page).to have_content(@invoice1.created_at.strftime("%A, %B %d, %Y"))
      expect(page).to have_content(@customer1.first_name)
      expect(page).to have_content(@customer1.last_name)


      expect(page).to_not have_content(@invoice2.id)
    end

    it 'displays items on invoice related to merchant' do
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@ii1.quantity)
      expect(page).to have_content(@item1.price_to_dollars)
      expect(page).to have_content(@ii1.status)

      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@ii2.quantity)
      expect(page).to have_content(@item2.price_to_dollars)
      expect(page).to have_content(@ii2.status)

      expect(page).to_not have_content(@item3.name)

      expect(page).to_not have_content(@item4.name)
    end

    it 'displays total revenue on invoice for merchant' do
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

      expect(page).to have_content("$#{@invoice1.total_revenue(@merchant1.id)}")
    end

    it 'can update status of invoice with select field' do
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

      expect(page).to have_content(@ii1.status)

      within(:css, "##{@ii1.id}") do
        select('packaged')
      end

      expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")

      within(:css, "##{@ii1.id}") do
        expect(page).to have_content('packaged')
      end
    end

    describe 'discounts' do
      it 'displays discounted revenue' do
        visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

        expect(page).to have_content("$#{@invoice1.total_revenue(@merchant1.id)}")
        expect(page).to have_content("$#{@invoice1.total_discount(@merchant1.id)}")
        expect(page).to have_content("$#{@invoice1.discounted_revenue(@merchant1.id)}")
      end

      it 'links to applied discount show page' do
        visit "/merchants/#{@merchant1.id}/invoices/#{@invoice2.id}"

        within(:css, "##{@ii3.id}") do
          click_on ("#{@discount2.percent}% Discount Applied")
        end

        expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/#{@discount2.id}")
      end
    end
  end
end
