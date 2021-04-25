class MerchantsController < ApplicationController

  def welcome
  end

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
    @top_five = @merchant.top_five_customers
    @ship_ready = @merchant.ship_ready  ##new


  #  @top_five_1 = Merchant.joins(:items).joins(:invoice_items).joins(:invoices).joins(:customers).joins(:transaction).where("id = ?", @merchant)

  #    @ship_ready = Merchant.joins(items: {invoice_items: :invoice}).where("merchants.id = ?", @merchant.id).where("invoice.status != ?", "cancelled").where("invoice_item.status != ?", "shiped").select(:name)

    # @customers = Customer.joins(invoices: {invoice_item: {item: :merchant}})
    #   .where("merchants.id = ?", @merchant.id).limit(5)
    #   .group(:customer_id).count
  end
end
