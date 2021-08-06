FactoryBot.define do
  factory :invoice do
    status { 1 }
    association :customer, factory: :customer
  end

  factory :cancelled_invoice do
    status { 0 }
    association :customer, factory: :customer
  end

  factory :completed_invoice do
    status { 2 }
    association :customer, factory: :customer
  end
end
