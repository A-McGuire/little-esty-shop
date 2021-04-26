require 'rails_helper'

RSpec.describe 'the merchant invoice show page: ', type: :feature do

  describe 'it displays info on the invoice: ' do
    it 'Invoice id' do
      merchant = Merchant.create(name: 'Bob Cella')
      merchant = Merchant.create(name: 'dud duddly')

      item_a = merchant.items.create!(name: "thing", description: "item of a thing", unit_price: 100)
      item_b = merchant.items.create!(name: "stuff", description: "bla bla bla", unit_price: 50)
      item_c = merchant.items.create!(name: "doo-hicky", description: "stuffy stuff", unit_price: 200)
      item_d = merchant.items.create!(name: "doo-hicky", description: "stuffy stuff", unit_price: 200)

      customer_a = Customer.create!(first_name: "albert", last_name: "anderston")
      customer_b = Customer.create!(first_name: "billy", last_name: "baxter")

      invoice = customer_a.invoices.create!(status: 0)

      invoice_item_1a = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 0, invoice_id: invoice.id, item_id: item_a.id)
      invoice_item_2a = InvoiceItem.create!(quantity: 10, unit_price: 50, status: 1, invoice_id: invoice.id, item_id: item_b.id)
      invoice_item_3a = InvoiceItem.create!(quantity: 1, unit_price: 500, status: 2, invoice_id: invoice.id, item_id: item_c.id)

      visit "merchants/#{merchant.id}/invoices/#{invoice.id}"

      expect(page).to have_content(invoice.id)
    end

    it 'Invoice status' do

      merchant = Merchant.create(name: 'Bob Cella')
      merchant_2 = Merchant.create(name: 'dud duddly')

      item_a = merchant.items.create!(name: "thing", description: "item of a thing", unit_price: 100)
      item_b = merchant.items.create!(name: "stuff", description: "bla bla bla", unit_price: 50)
      item_c = merchant.items.create!(name: "cool cat glasses", description: "stuffy stuff", unit_price: 200)
      item_d = merchant_2.items.create!(name: "doo-hicky", description: "al;skdfjkl;sa;j flk; sf", unit_price: 200)

      customer_a = Customer.create!(first_name: "albert", last_name: "anderston")
      customer_b = Customer.create!(first_name: "billy", last_name: "baxter")

      invoice = customer_a.invoices.create!(status: 0)

      invoice_item_1a = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 0, invoice_id: invoice.id, item_id: item_a.id)
      invoice_item_2a = InvoiceItem.create!(quantity: 10, unit_price: 50, status: 1, invoice_id: invoice.id, item_id: item_b.id)
      invoice_item_3a = InvoiceItem.create!(quantity: 1, unit_price: 500, status: 2, invoice_id: invoice.id, item_id: item_c.id)


      visit "merchants/#{merchant.id}/invoices/#{invoice.id}"

      expect(page).to have_content(invoice.status)
    end

    it 'Invoice created_at date in the format Monday, July 18, 2019' do

      merchant = Merchant.create(name: 'Bob Cella')
      merchant_2 = Merchant.create(name: 'dud duddly')

      item_a = merchant.items.create!(name: "thing", description: "item of a thing", unit_price: 100)
      item_b = merchant.items.create!(name: "stuff", description: "bla bla bla", unit_price: 50)
      item_c = merchant.items.create!(name: "cool cat glasses", description: "stuffy stuff", unit_price: 200)
      item_d = merchant_2.items.create!(name: "doo-hicky", description: "al;skdfjkl;sa;j flk; sf", unit_price: 200)

      customer_a = Customer.create!(first_name: "albert", last_name: "anderston")
      customer_b = Customer.create!(first_name: "billy", last_name: "baxter")

      invoice = customer_a.invoices.create!(status: 0)

      invoice_item_1a = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 0, invoice_id: invoice.id, item_id: item_a.id)
      invoice_item_2a = InvoiceItem.create!(quantity: 10, unit_price: 50, status: 1, invoice_id: invoice.id, item_id: item_b.id)
      invoice_item_3a = InvoiceItem.create!(quantity: 1, unit_price: 500, status: 2, invoice_id: invoice.id, item_id: item_c.id)

      visit "merchants/#{merchant.id}/invoices/#{invoice.id}"

      expect(page).to have_content(item_a.created_at.strftime("%A, %B %d, %Y"))
      expect(page).to have_content(item_b.created_at.strftime("%A, %B %d, %Y"))
      expect(page).to have_content(item_c.created_at.strftime("%A, %B %d, %Y"))
    end

    it 'Customer first and last names ' do
      merchant = Merchant.create(name: 'Bob Cella')
      merchant_2 = Merchant.create(name: 'dud duddly')

      item_a = merchant.items.create!(name: "thing", description: "item of a thing", unit_price: 100)
      item_b = merchant.items.create!(name: "stuff", description: "bla bla bla", unit_price: 50)
      item_c = merchant.items.create!(name: "cool cat glasses", description: "stuffy stuff", unit_price: 200)
      item_d = merchant_2.items.create!(name: "doo-hicky", description: "al;skdfjkl;sa;j flk; sf", unit_price: 200)

      customer_a = Customer.create!(first_name: "albert", last_name: "anderston")
      customer_b = Customer.create!(first_name: "billy", last_name: "baxter")

      invoice = customer_a.invoices.create!(status: 0)

      invoice_item_1a = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 0, invoice_id: invoice.id, item_id: item_a.id)
      invoice_item_2a = InvoiceItem.create!(quantity: 10, unit_price: 50, status: 1, invoice_id: invoice.id, item_id: item_b.id)
      invoice_item_3a = InvoiceItem.create!(quantity: 1, unit_price: 500, status: 2, invoice_id: invoice.id, item_id: item_c.id)

      visit "merchants/#{merchant.id}/invoices/#{invoice.id}"

      expect(page).to have_content(customer_a.first_name)
      expect(page).to have_content(customer_a.last_name)
    end
  end

  describe "displays info on all items: " do
    it ' item name ' do
      merchant = Merchant.create(name: 'Bob Cella')
      merchant_2 = Merchant.create(name: 'dud duddly')

      item_a = merchant.items.create!(name: "thing", description: "item of a thing", unit_price: 100)
      item_b = merchant.items.create!(name: "stuff", description: "bla bla bla", unit_price: 50)
      item_c = merchant.items.create!(name: "cool cat glasses", description: "stuffy stuff", unit_price: 200)
      item_d = merchant_2.items.create!(name: "doo-hicky", description: "al;skdfjkl;sa;j flk; sf", unit_price: 200)

      customer_a = Customer.create!(first_name: "albert", last_name: "anderston")
      customer_b = Customer.create!(first_name: "billy", last_name: "baxter")

      invoice = customer_a.invoices.create!(status: 0)

      invoice_item_1a = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 0, invoice_id: invoice.id, item_id: item_a.id)
      invoice_item_2a = InvoiceItem.create!(quantity: 10, unit_price: 50, status: 1, invoice_id: invoice.id, item_id: item_b.id)
      invoice_item_3a = InvoiceItem.create!(quantity: 1, unit_price: 500, status: 2, invoice_id: invoice.id, item_id: item_c.id)

      visit "merchants/#{merchant.id}/invoices/#{invoice.id}"

      expect(page).to have_content(item_a.name)
      expect(page).to have_content(item_b.name)
      expect(page).to have_content(item_c.name)
      expect(page).to have_no_content(item_d.name)
    end

    it ' quantity ordered ' do
      merchant = Merchant.create(name: 'Bob Cella')
      merchant_2 = Merchant.create(name: 'dud duddly')

      item_a = merchant.items.create!(name: "thing", description: "item of a thing", unit_price: 100)
      item_b = merchant.items.create!(name: "stuff", description: "bla bla bla", unit_price: 50)
      item_c = merchant.items.create!(name: "cool cat glasses", description: "stuffy stuff", unit_price: 200)
      item_d = merchant_2.items.create!(name: "doo-hicky", description: "al;skdfjkl;sa;j flk; sf", unit_price: 200)

      customer_a = Customer.create!(first_name: "albert", last_name: "anderston")
      customer_b = Customer.create!(first_name: "billy", last_name: "baxter")

      invoice = customer_a.invoices.create!(status: 0)

      invoice_item_1a = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 0, invoice_id: invoice.id, item_id: item_a.id)
      invoice_item_2a = InvoiceItem.create!(quantity: 10, unit_price: 50, status: 1, invoice_id: invoice.id, item_id: item_b.id)
      invoice_item_3a = InvoiceItem.create!(quantity: 1, unit_price: 500, status: 2, invoice_id: invoice.id, item_id: item_c.id)

      visit "merchants/#{merchant.id}/invoices/#{invoice.id}"

      expect(page).to have_content(invoice_item_1a.quantity)
      expect(page).to have_content(invoice_item_2a.quantity)
      expect(page).to have_content(invoice_item_3a.quantity)
    end

    it ' price of item ' do
      merchant = Merchant.create(name: 'Bob Cella')
      merchant_2 = Merchant.create(name: 'dud duddly')

      item_a = merchant.items.create!(name: "thing", description: "item of a thing", unit_price: 100)
      item_b = merchant.items.create!(name: "stuff", description: "bla bla bla", unit_price: 50)
      item_c = merchant.items.create!(name: "cool cat glasses", description: "stuffy stuff", unit_price: 200)
      item_d = merchant_2.items.create!(name: "doo-hicky", description: "al;skdfjkl;sa;j flk; sf", unit_price: 200)

      customer_a = Customer.create!(first_name: "albert", last_name: "anderston")
      customer_b = Customer.create!(first_name: "billy", last_name: "baxter")

      invoice = customer_a.invoices.create!(status: 0)

      invoice_item_1a = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 0, invoice_id: invoice.id, item_id: item_a.id)
      invoice_item_2a = InvoiceItem.create!(quantity: 10, unit_price: 50, status: 1, invoice_id: invoice.id, item_id: item_b.id)
      invoice_item_3a = InvoiceItem.create!(quantity: 1, unit_price: 500, status: 2, invoice_id: invoice.id, item_id: item_c.id)

      visit "merchants/#{merchant.id}/invoices/#{invoice.id}"

      expect(page).to have_content(invoice_item_1a.unit_price)
      expect(page).to have_content(invoice_item_2a.unit_price)
      expect(page).to have_content(invoice_item_3a.unit_price)
    end

    it ' status from invoice_item ' do
      merchant = Merchant.create(name: 'Bob Cella')
      merchant_2 = Merchant.create(name: 'dud duddly')

      item_a = merchant.items.create!(name: "thing", description: "item of a thing", unit_price: 100)
      item_b = merchant.items.create!(name: "stuff", description: "bla bla bla", unit_price: 50)
      item_c = merchant.items.create!(name: "cool cat glasses", description: "stuffy stuff", unit_price: 200)
      item_d = merchant_2.items.create!(name: "doo-hicky", description: "al;skdfjkl;sa;j flk; sf", unit_price: 200)

      customer_a = Customer.create!(first_name: "albert", last_name: "anderston")
      customer_b = Customer.create!(first_name: "billy", last_name: "baxter")

      invoice = customer_a.invoices.create!(status: 0)

      invoice_item_1a = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 0, invoice_id: invoice.id, item_id: item_a.id)
      invoice_item_2a = InvoiceItem.create!(quantity: 10, unit_price: 50, status: 1, invoice_id: invoice.id, item_id: item_b.id)
      invoice_item_3a = InvoiceItem.create!(quantity: 1, unit_price: 500, status: 2, invoice_id: invoice.id, item_id: item_c.id)

      visit "merchants/#{merchant.id}/invoices/#{invoice.id}"

      expect(page).to have_content(invoice_item_1a.status)
      expect(page).to have_content(invoice_item_2a.status)
      expect(page).to have_content(invoice_item_3a.status)
    end

    # it ' no info from other merchants items ' do
    # end
  end

  describe "displays total revenue: " do
    it ' price * quantity for all items ' do
      merchant = Merchant.create(name: 'Bob Cella')
      merchant_2 = Merchant.create(name: 'dud duddly')

      item_a = merchant.items.create!(name: "thing", description: "item of a thing", unit_price: 100)
      item_b = merchant.items.create!(name: "stuff", description: "bla bla bla", unit_price: 50)
      item_c = merchant.items.create!(name: "cool cat glasses", description: "stuffy stuff", unit_price: 200)
      item_d = merchant_2.items.create!(name: "doo-hicky", description: "al;skdfjkl;sa;j flk; sf", unit_price: 200)

      customer_a = Customer.create!(first_name: "albert", last_name: "anderston")
      customer_b = Customer.create!(first_name: "billy", last_name: "baxter")

      invoice = customer_a.invoices.create!(status: 0)

      invoice_item_1a = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 0, invoice_id: invoice.id, item_id: item_a.id)
      invoice_item_2a = InvoiceItem.create!(quantity: 10, unit_price: 50, status: 1, invoice_id: invoice.id, item_id: item_b.id)
      invoice_item_3a = InvoiceItem.create!(quantity: 1, unit_price: 500, status: 2, invoice_id: invoice.id, item_id: item_c.id)

      visit "merchants/#{merchant.id}/invoices/#{invoice.id}"

      expect(page).to have_content("1500")
    end
  end

  describe "name pending: " do
    it ' updates invoice status ' do
      merchant = Merchant.create(name: 'Bob Cella')

      item_a = merchant.items.create!(name: "thing", description: "item of a thing", unit_price: 100)
      item_b = merchant.items.create!(name: "stuff", description: "bla bla bla", unit_price: 50)
      item_c = merchant.items.create!(name: "cool cat glasses", description: "stuffy stuff", unit_price: 200)

      customer_a = Customer.create!(first_name: "albert", last_name: "anderston")

      invoice = customer_a.invoices.create!(status: 2)

      invoice_item_1a = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 0, invoice_id: invoice.id, item_id: item_a.id)
      invoice_item_2a = InvoiceItem.create!(quantity: 10, unit_price: 50, status: 1, invoice_id: invoice.id, item_id: item_b.id)
      invoice_item_3a = InvoiceItem.create!(quantity: 1, unit_price: 500, status: 2, invoice_id: invoice.id, item_id: item_c.id)

      visit "/merchants/#{merchant.id}/invoices/#{invoice.id}"

      within("#test") do
        expect(page).to have_content('completed')
        expect(page).to have_no_content('in progress')
      end
      click_on "Update Invoice Status"

      expect(page).to have_current_path("/merchants/#{merchant.id}/invoices/#{invoice.id}")

      within("#test") do
        expect(page).to have_content('in progress')
      end
    end
  end

  it 'has a link to each bulk discount that was applied' do
    merchant = Merchant.create!(name: "mel")
    merchant.bulk_discounts.create!(threshold: 10, discount: 0.1)
    merchant.bulk_discounts.create!(threshold: 20, discount: 0.2)
    merchant.bulk_discounts.create!(threshold: 30, discount: 0.3)
    customer = Customer.create!(first_name: "Abe", last_name: "Oldman")

    item1 = merchant.items.create!(name: "thing", description: "thingy", unit_price: 10)
    item2 = merchant.items.create!(name: "thing2", description: "thingy2", unit_price: 10)
    invoice1 = customer.invoices.create!(status: 0)

    invoice_item1 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 10, unit_price: 5, status: 0)
    invoice_item2 = InvoiceItem.create!(item: item2, invoice: invoice1, quantity: 20, unit_price: 5, status: 0)
    invoice_item3 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 30, unit_price: 5, status: 0)
    invoice_item4 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 1, unit_price: 5, status: 0)

    visit "/merchants/#{merchant.id}/invoices/#{invoice1.id}"

    within("#invoice_item-#{invoice_item1.id}") do
      expect(page).to have_link("Discount")
    end

    within("#invoice_item-#{invoice_item2.id}") do
      expect(page).to have_link("Discount")
    end

    within("#invoice_item-#{invoice_item3.id}") do
      expect(page).to have_link("Discount")
    end

    within("#invoice_item-#{invoice_item4.id}") do
      expect(page).to_not have_link("Discount")
    end
  end
end
