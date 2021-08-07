require 'rails_helper'

RSpec.describe 'Discount Edit' do
  before(:each) do
    @merchant1 = create(:merchant)

    @discount1 = create(:discount_high, merchant: @merchant1)
  end

  describe 'merchant' do
    it 'pre-poluates form' do
      visit "/merchants/#{@merchant1.id}/discounts/#{@discount1.id}/edit"

      expect(page).to have_field('Percent', with: '80')
      expect(page).to have_field('Quantity Threshold', with: '50')
    end

    it 'can update discount' do
      visit "/merchants/#{@merchant1.id}/discounts/#{@discount1.id}/edit"

      fill_in('Percent', with: '92')
      fill_in('Quantity Threshold', with: '45')
      click_on('Update Discount')

      expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/#{@discount1.id}")

      expect(page).to have_content('92')
      expect(page).to have_content('45')
    end
  end
end
