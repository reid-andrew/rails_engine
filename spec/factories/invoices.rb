FactoryBot.define do
  factory :invoice do
    status { ['shipped', 'paid'].sample }
    customer
    merchant
  end
end
