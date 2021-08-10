class Merchant::MerchantsController < ApplicationController

  def dashboard
    @merchant = Merchant.find(params[:merchant_id])
  end

  def index
    @merchants = Merchant.all
  end
end
