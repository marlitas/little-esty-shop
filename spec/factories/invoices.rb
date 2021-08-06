FactoryBot.define do
  factory :invoice do
    created_at { 1.day.ago }
    customer

    trait :cancelled do
      status :cancelled
    end

    trait :in_progress do
      status 'in progress'
    end

    trait :completed do
      status 'completed'
    end
  end
end

def customer_with_invoice(invoices_count: 5)
  FactoryBot.create(:customer) do |customer|
    FactoryBot.create_list(:invoice, invoices_count, customer: customer)
  end
end
