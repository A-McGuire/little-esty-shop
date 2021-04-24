require 'rails_helper'

RSpec.describe 'new bulk discount page', type: :feature do
  it 'shows the new bulk discount form' do
    merchant = Merchant.create!(name: 'Big Merch')

    visit "/merchants/#{merchant.id}/bulk_discounts/new"
    
    expect(find('form')).to have_content('Threshold')
    expect(find('form')).to have_content('Discount')
    expect(find('form')).to have_button('Create Bulk discount')
  end
  
  describe 'happy path' do
    it 'creates a new merchant when all fields are filled out' do
      merchant = Merchant.create!(name: 'Big Merch')
    
      visit "/merchants/#{merchant.id}/bulk_discounts/new"
      
      fill_in "Threshold", with: "50"
      fill_in "Discount", with: "0.5"
      click_button "Create Bulk discount"

      expect(current_path).to eq("/merchants/#{merchant.id}/bulk_discounts")
      expect(page).to have_content(50)
      expect(page).to have_content("50.0%")
      expect(page).to have_content("Bulk Discount Successfully Created")
    end
  end

  describe 'sad path' do
    it 'does not allow creation of a bulk discount w/o a threshold' do
      merchant = Merchant.create!(name: 'Big Merch')
    
      visit "/merchants/#{merchant.id}/bulk_discounts/new"
      
      fill_in "Threshold", with: "50"
      click_button "Create Bulk discount"

      expect(current_path).to eq("/merchants/#{merchant.id}/bulk_discounts/new")
      expect(page).to have_content("Discount can't be blank")
    end
    it 'does not allow creation of a bulk discount w/o a discount' do
      merchant = Merchant.create!(name: 'Big Merch')
    
      visit "/merchants/#{merchant.id}/bulk_discounts/new"
      
      fill_in "Discount", with: "0.50"
      click_button "Create Bulk discount"

      expect(current_path).to eq("/merchants/#{merchant.id}/bulk_discounts/new")
      expect(page).to have_content("Threshold can't be blank")
    end
  end
end