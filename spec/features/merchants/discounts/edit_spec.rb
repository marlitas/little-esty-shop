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
  end
end
