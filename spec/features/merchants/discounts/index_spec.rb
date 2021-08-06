require 'rails_helper'

RSpec.describe 'Discount Index' do
  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:disabled_merchant)

    @discount1 = create(:discount_high, merchant: @merchant1)
    @discount2 = create(:discount_medium, merchant: @merchant1)
    @discount3 = create(:discount_low, merchant: @merchant1)
    @discount4 = create(:discount, merchant: @merchant2 )

    allow_any_instance_of(Holiday).to receive(:name).and_return('Christmas Day')
    allow_any_instance_of(Holiday).to receive(:date).and_return('2021-12-24')
  end

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

    it 'displays upcoming holidays' do
      visit "/merchants/#{@merchant1.id}/discounts"

      expect(page).to have_content('Upcoming Holidays')
      expect(page).to have_content('Christmas Day')
      expect(page).to have_content('2021-12-24')
    end
  end
end
