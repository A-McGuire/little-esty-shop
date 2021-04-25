require 'rails_helper'

RSpec.describe 'bulk discount show page' do
  it 'displays the quantity threshold and percentage discount' do
    merchant1 = Merchant.create!(name: 'Big Merch')
    bulk_discount1 = merchant1.bulk_discounts.create!(threshold: 5, discount: 0.1)

    visit "/merchants/#{merchant1.id}/bulk_discounts/#{bulk_discount1.id}"

    expect(page).to have_content(bulk_discount1.threshold)
    expect(page).to have_content(bulk_discount1.discount)
  end

  it 'has a link to edit the bulk discount' do
    merchant1 = Merchant.create!(name: 'Big Merch')
    bulk_discount1 = merchant1.bulk_discounts.create!(threshold: 5, discount: 0.1)

    visit "/merchants/#{merchant1.id}/bulk_discounts/#{bulk_discount1.id}"

    expect(page).to have_link("Edit")
    click_link("Edit")
    expect(current_path).to eq("/merchants/#{merchant1.id}/bulk_discounts/#{bulk_discount1.id}/edit")
  end
end