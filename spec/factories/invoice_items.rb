FactoryBot.define do
  factory :invoice_item do
    unit_price { 1500 }
    quantity { 1 }
    item
    invoice


    trait :pending do
      status 0
    end

    trait :packaged do
      status 1
    end

    trait :shipped do
      status 2
    end

    trait :medium_quantity do
      quantity 5
    end

    trait :large_quantity do
      quantity 10
    end
  end
end

def invoice_with_ii(ii_count: 1)
  FactoryBot.create(:invoice) do |invoice|
    FactoryBot.create_list(:invoice_item, ii_count, invoice: invoice)
  end
end
