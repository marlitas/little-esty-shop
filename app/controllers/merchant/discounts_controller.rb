class Merchant::DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    json = NagerService.new.get_holiday
    #add method to filter holidays by three coming up
    @holidays = json.map do |holiday|
      Holiday.new(holiday)
    end
  end

  def new

  end

  def destroy
    Discount.find(params[:id]).destroy
    redirect_to "/merchants/#{params[:merchant_id]}/discounts"
  end
end
