class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
  end

  def new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = merchant.bulk_discounts.new(bulk_discount_params)
    if bulk_discount.save
      redirect_to "/merchants/#{merchant.id}/bulk_discounts", notice: "Bulk Discount Successfully Created"
    else
      redirect_to "/merchants/#{merchant.id}/bulk_discounts/new"
      flash[:alert] = "Error: #{error_message(bulk_discount.errors)}"
    end
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find(params[:id])
    merchant.bulk_discounts.delete(bulk_discount)
    redirect_to "/merchants/#{merchant.id}/bulk_discounts"
  end

  private
  def bulk_discount_params
    params.require(:bulk_discount).permit(:threshold, :discount, :merchant_id)
  end
end