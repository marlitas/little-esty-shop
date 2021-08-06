FactoryBot.define do
  factory :discount, class: Discount do
    percent { 20 }
    quantity_threshold {10}
    association :merchant, factory: :merchant
  end

  factory :discount_high, class: Discount do
    percent { 80 }
    quantity_threshold {50}
    association :merchant, factory: :merchant
  end

  factory :discount_medium, class: Discount do
    percent { 50 }
    quantity_threshold {20}
    association :merchant, factory: :merchant
  end

  factory :discount_low, class: Discount do
    percent { 10 }
    quantity_threshold {5}
    association :merchant, factory: :merchant
  end
end

# def merchant_with_discounts(discount_count: 2)
#   FactoryBot.create(:merchant) do |merchant|
#     FactoryBot.create_list(:discount, discount_count, merchant: merchant)
#   end
# end
