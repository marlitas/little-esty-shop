require 'rails_helper'

RSpec.describe 'Application View' do
  describe 'visitor' do
    it 'displays repo name' do
      visit "/admin"
      expect(page).to have_content('little-esty-shop')
    end
  end
end
