class BulkDiscountsController < ApplicationController
  before_action(:set_merchant, only: [:index, :show, :create, :destroy])
  before_action(:set_bulk_discount, only: [:show, :edit, :destroy])

  def set_bulk_discount
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def index
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show
    @bulk_discount
    @merchant
  end

  def new
  end

  def create
    bulk_discount = @merchant.bulk_discounts.new(bulk_discount_params)
    if bulk_discount.save
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts", notice: "Bulk Discount Successfully Created"
    else
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts/new"
      flash[:alert] = "Error: #{error_message(bulk_discount.errors)}"
    end
  end

  def edit
    @bulk_discount
  end

  def destroy
    @merchant.bulk_discounts.delete(@bulk_discount)
    redirect_to "/merchants/#{@merchant.id}/bulk_discounts"
  end

  private
  def bulk_discount_params
    params.require(:bulk_discount).permit(:threshold, :discount, :merchant_id)
  end
end