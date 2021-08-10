require 'rails_helper'

RSpec.describe 'Merchant Index' do
  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
  end

  it 'displays all merchants' do
    visit "/merchants"

    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content(@merchant2.name)
    expect(page).to have_content(@merchant3.name)
  end

  it 'links you to a merchant dashboard' do
    visit '/merchants'

    click_on("#{@merchant1.name}")

    expect(current_path).to eq("/merchants/#{@merchant1.id}/dashboard")
  end
end
