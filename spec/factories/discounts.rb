FactoryBot.define do
  factory :discount do
    percent { 15 }
    quantity_threshold {20}
    merchant

  end
end

def merchant_with_discounts(discount_count: 2)
  FactoryBot.create(:merchant) do |merchant|
    FactoryBot.create_list(:discount, discount_count, merchant: merchant)
  end
end
