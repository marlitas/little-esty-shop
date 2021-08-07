FactoryBot.define do
  factory :invoice_item do
    unit_price { 2000 }
    quantity { 1 }
    status { 1 }
    association :invoice, factory: :invoice
    association :item, factory: :item
  end

  factory :invoice_item_high do
    unit_price { 900000 }
    quantity { 10 }
    status { 1 }
    association :invoice_high, factory: :invoice
    association :item_high, factory: :item
  end

  factory :invoice_item_medium do
    unit_price { 50000 }
    quantity { 5 }
    status { 1 }
    association :invoice_high, factory: :invoice
    association :item_high, factory: :item
  end

  factory :invoice_item_low do
    unit_price { 100 }
    quantity { 1 }
    status { 1 }
    association :invoice_high, factory: :invoice
    association :item_high, factory: :item
  end

  factory :pending_invoice_item do
    unit_price { 100 }
    quantity { 1 }
    status { 0 }
    association :invoice_high, factory: :invoice
    association :item_high, factory: :item
  end

  factory :shipped_invoice_item do
    unit_price { 2000 }
    quantity { 1 }
    status { 2 }
    association :invoice, factory: :invoice
    association :item, factory: :item
  end
end
