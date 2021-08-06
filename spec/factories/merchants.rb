FactoryBot.define do
  factory :merchant, class: Merchant do
    name {Faker::DcComics.hero}
    status { true }
  end

  factory :disabled_merchant, class: Merchant do
    name { Faker::DcComics.name }
    status { false }
  end
end
