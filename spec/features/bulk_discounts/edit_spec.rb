require 'rails_helper'

RSpec.describe 'bulk discount edit page', type: :feature do
  it 'shows the bulk discount edit form' do
    merchant1 = Merchant.create!(name: 'Big Merch')
    bulk_discount1 = merchant1.bulk_discounts.create!(threshold: 5, discount: 0.1)
    
    visit "/merchants/#{merchant1.id}/bulk_discounts/#{bulk_discount1.id}/edit"
    
    expect(find('form')).to have_content('Threshold')
    expect(find('form')).to have_content('Discount')
    expect(find('form')).to have_button('Update Bulk discount')
  end
  
  describe 'happy path' do
    it 'updates and redirects to the bulk discount show page, displays flash' do
      merchant1 = Merchant.create!(name: 'Big Merch')
      bulk_discount1 = merchant1.bulk_discounts.create!(threshold: 5, discount: 0.1)
      
      visit "/merchants/#{merchant1.id}/bulk_discounts/#{bulk_discount1.id}/edit"
  
      fill_in "threshold", with: 10
      fill_in "discount", with: 0.1
      click_button "Update Bulk discount"
      expect(current_path).to eq("/merchants/#{merchant1.id}/bulk_discounts/#{bulk_discount1.id}")
      expect(page).to have_content("Bulk Discount Updated.")
    end
  end

  describe 'sad path' do
    it 'does not allow a blank threshold field' do
      merchant1 = Merchant.create!(name: 'Big Merch')
      bulk_discount1 = merchant1.bulk_discounts.create!(threshold: 5, discount: 0.1)
      
      visit "/merchants/#{merchant1.id}/bulk_discounts/#{bulk_discount1.id}/edit"
  
      fill_in "threshold", with: ''
      fill_in "discount", with: 0.1
      click_button "Update Bulk discount"
      expect(current_path).to eq("/merchants/#{merchant1.id}/bulk_discounts/#{bulk_discount1.id}/edit")
      expect(page).to have_content("Threshold can't be blank")
    end

    it 'does not allow a blank discount field' do
      merchant1 = Merchant.create!(name: 'Big Merch')
      bulk_discount1 = merchant1.bulk_discounts.create!(threshold: 5, discount: 0.1)
      
      visit "/merchants/#{merchant1.id}/bulk_discounts/#{bulk_discount1.id}/edit"
  
      fill_in "threshold", with: 10
      fill_in "discount", with: ''
      click_button "Update Bulk discount"
      expect(current_path).to eq("/merchants/#{merchant1.id}/bulk_discounts/#{bulk_discount1.id}/edit")
      expect(page).to have_content("Discount can't be blank")
    end
  end
end