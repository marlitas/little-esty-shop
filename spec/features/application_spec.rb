require 'rails_helper'

RSpec.describe 'Application View' do
  describe 'visitor' do
    it 'displays repo name' do
      visit "/admin"

      save_and_open_page
      
      expect(page).to have_content('little-esty-shop')
      expect(page).to have_content('marlita')
      expect(page).to have_content('Jtpiland')
      expect(page).to have_content('sami-p')
      expect(page).to have_content('danembb')
    end
  end
end
