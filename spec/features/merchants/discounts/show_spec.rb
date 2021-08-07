require 'rails_helper'

RSpec.describe 'Discount Show' do
  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:disabled_merchant)

    @discount1 = create(:discount_high, merchant: @merchant1)
    @discount2 = create(:discount_medium, merchant: @merchant1)
    @discount3 = create(:discount_low, merchant: @merchant1)
    @discount4 = create(:discount, merchant: @merchant2 )
  end

  describe 'links' do
    it 'can take you to edit page' do
      visit "/merchants/#{@merchant1.id}/discounts/#{@discount1.id}"

      click_on('Edit Discount')

      expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/#{@discount1.id}/edit")
    end
  end

  describe 'merchant' do
    it 'displays discount attributes' do
      visit "/merchants/#{@merchant1.id}/discounts/#{@discount1.id}"

      expect(page).to have_content(@discount1.percent)
      expect(page).to have_content(@discount1.quantity_threshold)

      expect(page).to_not have_content(@discount3.percent)
      expect(page).to_not have_content(@discount2.quantity_threshold)
    end
  end
end
