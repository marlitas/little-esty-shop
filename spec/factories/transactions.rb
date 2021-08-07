FactoryBot.define do
  factory :transaction do
    credit_card_number {Faker::Stripe.valid_card}
    credit_card_expiration_date {'02/04'}
    association :invoice, factory: :invoice
    result {0}
  end

  factory :failed_transaction, class: Transaction do
    credit_card_number {Faker::Stripe.valid_card}
    credit_card_expiration_date {'02/04'}
    association :invoice, factory: :invoice
    result {1}
  end
end
