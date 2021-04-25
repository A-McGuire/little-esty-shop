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
  
  it 'updates and redirects to the bulk discount show page, displays flash' do
    merchant1 = Merchant.create!(name: 'Big Merch')
    bulk_discount1 = merchant1.bulk_discounts.create!(threshold: 5, discount: 0.1)
    
    visit "/merchants/#{merchant1.id}/bulk_discounts/#{bulk_discount1.id}/edit"

    fill_in "bulk_discount_threshold", with: 10
    fill_in "bulk_discount_discount", with: 0.1
    click_button "Update Bulk discount"
    expect(current_path).to eq("/merchants/#{merchant1.id}/bulk_discounts/#{bulk_discount1.id}")
    expect(page).to have_content("Bulk Discount Updated.")
  end
end