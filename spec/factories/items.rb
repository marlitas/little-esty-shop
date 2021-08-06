FactoryBot.define do
  factory :item do
    name { "Bouncy Ball" }
    description { "So Bouncy" }
    unit_price { 2000 }
    merchant
  end
  trait :enabled do
    status 0
  end

  trait :disabled do
    status 1
  end

  # factory :merchant do
  #   name { 'Sparkys Shop' }
  #
  #   factory :merchant_with_items do
  #     transient do
  #       items_count { 2 }
  #     end
  #
  #     items do
  #       Array.new(items_count) { association(:post) }
  #     end
  #   end
  # end



end


def merchant_with_items(items_count: 2)
  FactoryBot.create(:merchant) do |merchant|
    FactoryBot.create_list(:item, items_count, merchant: merchant)
  end
end
