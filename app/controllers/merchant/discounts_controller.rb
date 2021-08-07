class Merchant::DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    json = NagerService.new.get_holiday
    #add method to filter holidays by three coming up
    @holidays = json.map do |holiday|
      Holiday.new(holiday)
    end
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def edit
    @discount = Discount.find(params[:id])
  end

  def new
    @discount = Discount.new
  end

  def create
    Discount.create!(percent: params[:discount][:percent], quantity_threshold: params[:discount][:quantity_threshold], merchant_id: params[:merchant_id])

    redirect_to "/merchants/#{params[:merchant_id]}/discounts"
  end

  def destroy
    Discount.find(params[:id]).destroy
    redirect_to "/merchants/#{params[:merchant_id]}/discounts"
  end

  def discount_params
    params.permit( :merchant_id)
  end
end
