class Merchant::DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    json = NagerService.new.get_holiday
    #add method to filter holidays by three coming up
    @holidays = json.map do |holiday|
      Holiday.new(holiday)
    end
  end
end
