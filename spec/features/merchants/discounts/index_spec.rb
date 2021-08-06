require 'rails_helper'

RSpec.describe 'Discount Index' do
  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:disabled_merchant)

    @discount1 = create(:discount_high)
    @discount2 = create(:discount_medium)
    @discount3 = create(:discount_low)
    @discount4 = create(:discount, merchant: @merchant2 )

  end
  # As a merchant
  # When I visit my merchant dashboard
  # Then I see a link to view all my discounts
  # When I click this link
  # Then I am taken to my bulk discounts index page
  # Where I see all of my bulk discounts including their
  # percentage discount and quantity thresholds
  # And each bulk discount listed includes a link to its show page
  describe 'merchant' do
    it 'displays discounts merchant has' do
      visit "/merchants/#{@merchant1.id}/discounts"

      expect(page).to have_content(@discount1.id)
      expect(page).to have_content(@discount1.percent)
      expect(page).to have_content(@discount1.quantity_threshold)
      expect(page).to have_content(@discount2.id)
      expect(page).to have_content(@discount2.percent)
      expect(page).to have_content(@discount2.quantity_threshold)
      expect(page).to have_content(@discount3.id)
      expect(page).to have_content(@discount3.percent)
      expect(page).to have_content(@discount3.quantity_threshold)

      expect(page).to_not have_content(@discount4.id)
    end
  end
end
