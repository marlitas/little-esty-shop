FactoryBot.define do
  factory :merchant do
    name {'Sparkys Shop'}

    trait :enabled do
      status true
    end

    trait :disabled do
      status false
    end
  end
end
