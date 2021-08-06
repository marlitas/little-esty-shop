FactoryBot.define do
  factory :transaction do
    credit_card_number {'123456789'}
    credit_card_number_expiration_date {'02/04'}
    invoice

    trait :success do
      result 0
    end

    trait :failed do
      result 1
    end
  end
end

def invoice_with_transactions(transactions_count: 3)
  FactoryBot.create(:invoice) do |invoice|
    FactoryBot.create_list(:transaction, transactions_count, invoice: invoice)
  end
end
