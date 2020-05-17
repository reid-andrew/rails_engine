FactoryBot.define do
  factory :item do
    name { Faker::Appliance.equipment }
    description { Faker::Movies::PrincessBride.quote }
    unit_price { Faker::Number.positive }
    merchant
  end
end
