class Merchant::InvoiceItemsController < ApplicationController
  def update
    ii = InvoiceItem.find(params[:merchant_id])
    item = Item.find(ii.item_id)
    ii.update!(status: params[:invoice_item][:status])

    redirect_to "/merchants/#{item.merchant_id}/invoices/#{params[:id]}"
  end
end
