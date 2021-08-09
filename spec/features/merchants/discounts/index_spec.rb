require 'rails_helper'

RSpec.describe 'Discount Index' do
  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:disabled_merchant)
    @merchant3 = create(:merchant)

    @discount1 = create(:discount_high, merchant: @merchant1)
    @discount2 = create(:discount_medium, merchant: @merchant1)
    @discount3 = create(:discount_low, merchant: @merchant1)
    @discount4 = create(:discount, merchant: @merchant2 )

    allow_any_instance_of(NagerService).to receive(:get_holiday).and_return([{localName: 'Christmas Day', date: '2021-12-24'}, {localName: 'Thanksgiving', date: '2021-11-28'}, {localName: 'New Years Eve', date: '2021-12-31'}, {localName: 'Labor Day', date: '2021-09-04'}, {localName: 'Independence Day', date: '2021-07-04'}])
  end

  describe 'links' do
    it 'directs you to new discount' do
      visit "/merchants/#{@merchant1.id}/discounts"
      click_on('Add New Discount')

      expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/new")
    end

    it 'can delete a discount' do
      visit "/merchants/#{@merchant1.id}/discounts"
      expect(page).to have_content(@discount1.id)

      within(:css, "##{@discount1.id}") do
        click_on('Delete Discount')
      end

      expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts")
      expect(page).to_not have_content(@discount1.id)
    end

     it 'directs you to discount show' do
       visit "/merchants/#{@merchant1.id}/discounts"

       within(:css, "##{@discount1.id}") do
         click_on("Discount ID: #{@discount1.id}")
       end

       expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/#{@discount1.id}")
     end
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

    it 'loads when merchant has no discounts' do
      visit "/merchants/#{@merchant3.id}/discounts"

      expect(page).to have_content('Add New Discount')
      expect(page).to_not have_content(@discount4.id)
    end

    it 'displays upcoming holidays' do
      visit "/merchants/#{@merchant1.id}/discounts"

      expect(page).to have_content('Upcoming Holidays')
      expect('Labor Day').to appear_before('Thanksgiving')
      expect('Thanksgiving').to appear_before('Christmas Day')

      expect(page).to have_content('2021-12-24')
      expect(page).to have_content('2021-11-28')

      expect(page).to_not have_content('Independence Day')
    end
  end
end
