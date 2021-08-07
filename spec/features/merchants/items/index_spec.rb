require 'rails_helper'

RSpec.describe 'merchant items index page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Sparkys Shop')
    @merchant2 = Merchant.create!(name: 'BBs Petstore')

    @customer1 = Customer.create!(first_name: 'Petey', last_name: 'Wimbley')
    @customer2 = Customer.create!(first_name: 'Victoria', last_name: 'Jenkins')
    @customer3 = Customer.create!(first_name: 'Pedro', last_name: 'Oscar')
    @customer4 = Customer.create!(first_name: 'Scarlett', last_name: 'Redsley')
    @customer5 = Customer.create!(first_name: 'Annie', last_name: 'Snip')
    @customer6 = Customer.create!(first_name: 'Goran', last_name: 'Babalia')

    @item1 = @merchant1.items.create!(name: 'Teddy Bear', description: 'So fuzzy', unit_price: 2000)
    @item2 = @merchant1.items.create!(name: 'Toy Car', description: 'So fast', unit_price: 30000)
    @item3 = @merchant1.items.create!(name: 'Bouncy Ball', description: 'So bouncy', unit_price: 5000)
    @item4 = @merchant1.items.create!(name: 'Dog Bone', description: 'So chewy', unit_price: 8000)
    @item5 = @merchant1.items.create!(name: 'Twist Tie', description: 'So twisty', unit_price: 100)
    @item6 = @merchant1.items.create!(name: 'Snake-on-a-Rope', description: 'So squiggly', unit_price: 500)
    @item7 = @merchant1.items.create!(name: 'Chonky Rat', description: 'So chonky', unit_price: 1000)

    @invoice1 = @customer1.invoices.create!(status: 2)
    @invoice2 = @customer2.invoices.create!(status: 2)
    @invoice3 = @customer3.invoices.create!(status: 2)
    @invoice4 = @customer4.invoices.create!(status: 2)
    @invoice5 = @customer5.invoices.create!(status: 2)
    @invoice6 = @customer6.invoices.create!(status: 2)
    @invoice7 = @customer5.invoices.create!(status: 1, created_at: "2012-03-20 09:54:09 UTC")

    @transaction1 = @invoice5.transactions.create!(credit_card_number: "0123456789", credit_card_expiration_date: '12/31', result: 0)
    @transaction2 = @invoice5.transactions.create!(credit_card_number: "9876543210", credit_card_expiration_date: '01/01', result: 0)
    @transaction3 = @invoice5.transactions.create!(credit_card_number: "4444444444", credit_card_expiration_date: '06/07', result: 0)
    @transaction4 = @invoice5.transactions.create!(credit_card_number: "2222111100", credit_card_expiration_date: '02/02', result: 0)
    @transaction5 = @invoice5.transactions.create!(credit_card_number: "7934759378", credit_card_expiration_date: '03/20', result: 0)
    @transaction6 = @invoice6.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)
    @transaction7 = @invoice6.transactions.create!(credit_card_number: "1231231312", credit_card_expiration_date: '09/34', result: 0)
    @transaction8 = @invoice6.transactions.create!(credit_card_number: "7453534534", credit_card_expiration_date: '12/12', result: 0)
    @transaction9 = @invoice6.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '06/10', result: 0)
    @transaction10 = @invoice2.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)
    @transaction11 = @invoice2.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)
    @transaction12 = @invoice2.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)
    @transaction13 = @invoice4.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)
    @transaction14 = @invoice4.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)
    @transaction15 = @invoice1.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 0)
    @transaction16 = @invoice1.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 1)
    @transaction17 = @invoice3.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 1)
    @transaction18 = @invoice3.transactions.create!(credit_card_number: "7894739999", credit_card_expiration_date: '04/20', result: 1)

    @invoice1.items << [@item1]
    @invoice2.items << [@item1]
    @invoice3.items << [@item1]
    @invoice4.items << [@item2]
    @invoice5.items << [@item2]
    @invoice6.items << [@item1]

    @ii1 = InvoiceItem.create!(quantity: 4, unit_price: 2000, status: 0, invoice: @invoice1, item: @item1 ) #8000
    @ii2 = InvoiceItem.create!(quantity: 1, unit_price: 30000, status: 0, invoice: @invoice1, item: @item2 ) #30000
    @ii3 = InvoiceItem.create!(quantity: 2, unit_price: 5000, status: 0, invoice: @invoice1, item: @item3 ) #10000
    @ii4 = InvoiceItem.create!(quantity: 2, unit_price: 8000, status: 0, invoice: @invoice1, item: @item4 ) #16000
    @ii5 = InvoiceItem.create!(quantity: 6, unit_price: 100, status: 0, invoice: @invoice1, item: @item5 ) #600
    @ii6 = InvoiceItem.create!(quantity: 19, unit_price: 500, status: 0, invoice: @invoice1, item: @item6 ) #9500
    @ii7 = InvoiceItem.create!(quantity: 50, unit_price: 1000, status: 0, invoice: @invoice1, item: @item7 ) #50000
  end
  describe 'links' do
    it 'can take you to the an items show page' do
      visit "merchants/#{@merchant1.id}/items"
      within(:css, "##{@item1.id}") do

        click_on(@item1.name)

      end
      expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}")
    end
  end

  describe 'as a merchant when i visit my items index page' do

    it 'displays all the merchants items' do
      visit "merchants/#{@merchant1.id}/items"

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@item3.name)
      expect(page).to_not have_content(@item4.name)
    end

    it 'can create an item by interacting with a form' do
      visit "/merchants/#{@merchant1.id}/items"

      expect(page).to have_content("Create a New Item")
      expect(page).to have_link("Create a New Item")

      click_on "Create a New Item"
      expect(current_path).to eq("/merchants/#{@merchant1.id}/items/new")

      fill_in "Name", with: "Chewbacca Chew Toy"
      fill_in "Description", with: "So Chewy"
      fill_in "Unit Price", with: 699
      click_on "Submit"
      expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
      expect(page).to have_content("Chewbacca Chew Toy")
      expect(page).to have_content("So Chewy")
      expect(page).to have_content(699)
    end

    it 'can create and display top 5 merchant items' do
      visit "/merchants/#{@merchant1.id}/items"
      within(:css, ".top-5-items") do

        expect(page).to_not have_content(@item1.name)
        expect(page).to_not have_content(@item5.name)
        expect(@item7.name).to appear_before(@item2.name)
        expect(@item2.name).to appear_before(@item4.name)
        expect(@item4.name).to appear_before(@item3.name)
        expect(@item3.name).to appear_before(@item6.name)

      end
    end

    it 'displays top selling date of top items' do
      visit "merchants/#{@merchant1.id}/items"

      expect(page).to have_content("Top selling date for #{@item1.name} was #{@item1.created_at.strftime('%A, %B %d, %Y')}")
    end

    it 'displays items by their status' do
      @item1.update!(status: 0)
      @item2.update!(status: 1)

      visit "merchants/#{@merchant1.id}/items"

      within(:css, "#enabled") do
        expect(page).to have_content('Enabled Items')
        expect(page).to have_content(@item1.name)
        expect(page).to_not have_content(@item2.name)
      end

      within(:css, "#disabled") do
        expect(page).to have_content('Disabled Items')
        expect(page).to have_content(@item2.name)
        expect(page).to_not have_content(@item1.name)
      end
    end

    it 'can enable and disable items' do
      @item1.update!(status: 0)
      visit "merchants/#{@merchant1.id}/items"

      within(:css, "##{@item1.id}") do
        expect(page).to have_content('Status: enabled')

        click_on('Disable')
      end

      expect(current_path).to eq("/merchants/#{@merchant1.id}/items")

      within(:css, "##{@item1.id}") do
        expect(page).to have_content('Status: disabled')
        click_on('Enable')
      end

      expect(current_path).to eq("/merchants/#{@merchant1.id}/items")

      within(:css, "##{@item1.id}") do
        expect(page).to have_content('Status: enabled')
      end
    end
  end
end
