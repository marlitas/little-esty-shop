class AddDiscountToInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    add_column :invoice_items, :discount, :integer
  end
end
