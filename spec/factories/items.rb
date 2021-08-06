FactoryBot.define do
  factory :item, class: Item do
    name { Faker::Commerce.product_name }
    description { Faker::ChuckNorris.fact }
    unit_price { 2000 }
    association :merchant, factory: :merchant
    status { 0 }
  end

  factory :item_high, class: Item do
    name { Faker::Commerce.product_name }
    description { Faker::ChuckNorris.fact }
    unit_price { 900000 }
    association :merchant, factory: :merchant
    status { 0 }
  end

  factory :item_medium, class: Item do
    name { Faker::Commerce.product_name }
    description { Faker::ChuckNorris.fact }
    unit_price { 50000 }
    association :merchant, factory: :merchant
    status { 0 }
  end

  factory :item_low, class: Item do
    name { Faker::Commerce.product_name }
    description { Faker::ChuckNorris.fact }
    unit_price { 100 }
    association :merchant, factory: :merchant
    status { 0 }
  end

  factory :disabled_item, class: Item do
    name { Faker::Commerce.product_name }
    description { Faker::ChuckNorris.fact }
    unit_price { 100 }
    association :merchant, factory: :merchant
    status { 1 }
  end
end
