class Merchant::InvoicesController < ApplicationController

  def index
    @invoices = Invoice.merchant_invoices(params[:merchant_id])
  end

  def show
    @invoice = Invoice.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
    @invoice.apply_item_discount(@merchant.id)
  end
end
