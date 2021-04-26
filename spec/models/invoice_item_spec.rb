require "rails_helper"

RSpec.describe InvoiceItem do
  describe "relationships" do
    it {should belong_to :item}
    it {should belong_to :invoice}
  end

  describe 'instance methods' do
    describe 'best_discount' do
      it 'finds all applicable bulk discounts, returns greatest discount' do
        merchant = Merchant.create!(name: "mel")
        merchant.bulk_discounts.create!(threshold: 10, discount: 0.1)
        merchant.bulk_discounts.create!(threshold: 20, discount: 0.2)
        merchant.bulk_discounts.create!(threshold: 30, discount: 0.3)
        merchant.bulk_discounts.create!(threshold: 40, discount: 0.4)
        merchant.bulk_discounts.create!(threshold: 15, discount: 0.1)
        customer = Customer.create!(first_name: "Abe", last_name: "Oldman")

        item1 = merchant.items.create!(name: "thing", description: "thingy", unit_price: 10)
        invoice1 = customer.invoices.create!(status: 0)

        invoice_item1 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 20, unit_price: 5, status: 2) #50
        invoice_item2 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 2, unit_price: 5, status: 0) #10
        invoice_item3 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 3, unit_price: 5, status: 1) #15
        invoice_item4 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 4, unit_price: 5, status: 2) #20

        expect(invoice_item1.best_discount).to eq(0.2)
      end
    end
  end
end
