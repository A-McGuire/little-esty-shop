class MerchantsController < ApplicationController

  def welcome
  end

  def show
    @merchant = Merchant.find(params[:id])

  #  @top_five = Merchant.joins(items: :invoice_items).joins(:invoices)#.joins(:customers).joins(:transaction)
  #  @top_five_1 = Merchant.joins(:items).joins(:invoice_items).joins(:invoices).joins(:customers).joins(:transaction).where("id = ?", @merchant)
  #  @top_five_1 = Merchant.joins(:items).joins(:invoice_items)
    @top_five = @merchant.top_five_customers

#    @ship_ready = Merchant.joins(items: {invoice_items: :invoice}).where("merchants.id = ?", @merchant.id).where("invoice.status != ?", "cancelled").where("invoice_item.status != ?", "shiped").select(:name)

    # @customers = Customer.joins(invoices: {invoice_item: {item: :merchant}})
    #   .where("merchants.id = ?", @merchant.id).limit(5)
    #   .group(:customer_id).count

  end

  def index
    @merchants = Merchant.all
  end

  # def item_index
  #   @merchant = Merchant.find(params[:id])
  #   # @items = @merchant.items.all
  #   @enabled_items = (@merchant.items.all).enabled
  #   @disabled_items = (@merchant.items.all).disabled
  # end
  #
  # def item_create
  #   @merchant = Merchant.find(params[:id])
  #   # item = @merchant.items.new()
  #   item = Item.new({name: params[:name], description: params[:description], unit_price: params[:unit_price], able: params[:able], merchant_id: @merchant.id})
  #   item.save
  #   redirect_to "/merchants/#{@merchant.id}/items"
  # end
  #
  # def item_new
  #   @merchant = Merchant.find(params[:id])
  # end
  #
  # def item_edit
  #   @merchant = Merchant.find(params[:merchant_id])
  #   @item = @merchant.items.find(params[:item_id])
  # end
  #
  # def item_update
  #   @merchant = Merchant.find(params[:merchant_id])
  #   # item = @merchant.items.find(params[:item_id])
  #   item = Item.find(params[:item_id])
  #   binding.pry
  #   if params[:name]
  #     item.update({
  #       name: params[:name],
  #       description: params[:description],
  #       unit_price: params[:unit_price],
  #       able: params[:able]
  #       })
  #   else
  #     item.update({able: params[:able]})
  #   end
  #   item.save
  #   flash[:alert] = "Item was successfully updated."
  #   redirect_to "/merchants/#{@merchant.id}/items"
  # end
  #
  #
  # def item_show
  #   @merchant = Merchant.find(params[:merchant_id])
  #   @item = @merchant.items.find(params[:item_id])
  # end

end
