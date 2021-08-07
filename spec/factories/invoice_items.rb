FactoryBot.define do
  factory :invoice_item, class: InvoiceItem do
    unit_price { 2000 }
    quantity { 1 }
    status { 1 }
    association :invoice, factory: :invoice
    association :item, factory: :item
  end

  factory :invoice_item_high, class: InvoiceItem do
    unit_price { 900000 }
    quantity { 10 }
    status { 1 }
    association :invoice, factory: :invoice
    association :item, factory: :item_high
  end

  factory :invoice_item_medium, class: InvoiceItem do
    unit_price { 50000 }
    quantity { 5 }
    status { 1 }
    association :invoice, factory: :invoice
    association :item, factory: :item_medium
  end

  factory :invoice_item_low, class: InvoiceItem do
    unit_price { 100 }
    quantity { 1 }
    status { 1 }
    association :invoice, factory: :invoice
    association :item, factory: :item_low
  end

  factory :pending_invoice_item, class: InvoiceItem do
    unit_price { 100 }
    quantity { 1 }
    status { 0 }
    association :invoice, factory: :invoice
    association :item, factory: :item
  end

  factory :shipped_invoice_item, class: InvoiceItem do
    unit_price { 2000 }
    quantity { 1 }
    status { 2 }
    association :invoice, factory: :invoice
    association :item, factory: :item
  end
end
