require 'rails_helper'

RSpec.describe 'welcome index' do
  describe 'visitor' do
    it 'welcomes visitors' do
      visit '/'

      expect(page).to have_content('Welcome to Discount Warehouse')
    end
  end
end
