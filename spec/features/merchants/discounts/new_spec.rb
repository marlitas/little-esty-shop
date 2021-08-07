require 'rails_helper'

RSpec.describe 'New Discount' do
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
    it 'can create new discount' do
      visit "/merchants/#{@merchant1.id}/discounts/new"

      fill_in('Percent', with:('40'))
      fill_in('Quantity Threshold', with:('16'))
      click_on('Create Discount')

      expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts")

      save_and_open_page
      expect(page).to have_content('16')
      expect(page).to have_content('40')
    end
  end
end
