require 'rails_helper'

RSpec.describe 'bulk discounts show page' do
  it 'displays all bulk discounts for a specific merchant' do
    merchant1 = Merchant.create!(name: 'Big Merch')
    merchant2 = Merchant.create!(name: 'Lil Merch')
    
    bulk_discount1 = merchant1.bulk_discounts.create!(threshold: 5, discount: 0.1)
    bulk_discount2 = merchant1.bulk_discounts.create!(threshold: 10, discount: 0.2)
    bulk_discount3 = merchant1.bulk_discounts.create!(threshold: 15, discount: 0.3)
    
    bulk_discount4 = merchant2.bulk_discounts.create!(threshold: 6, discount: 0.1)
    bulk_discount5 = merchant2.bulk_discounts.create!(threshold: 11, discount: 0.2)
    bulk_discount6 = merchant2.bulk_discounts.create!(threshold: 16, discount: 0.3)
    
    visit "/merchants/#{merchant1.id}/bulk_discounts"
    
    expect(page).to have_content(bulk_discount1.threshold)
    expect(page).to have_content(bulk_discount2.threshold)
    expect(page).to have_content(bulk_discount3.threshold)
    
    expect(page).to_not have_content(bulk_discount4.threshold)
    expect(page).to_not have_content(bulk_discount5.threshold)
    expect(page).to_not have_content(bulk_discount6.threshold)
  end
  
  it 'has a link to create a new bulk discount' do
    merchant = Merchant.create!(name: 'Big Merch')

    visit "/merchants/#{merchant.id}/bulk_discounts"
    
    expect(page).to have_link("Create New Bulk Discount")
    click_link "Create New Bulk Discount"
    expect(current_path).to eq("/merchants/#{merchant.id}/bulk_discounts/new")
  end
end