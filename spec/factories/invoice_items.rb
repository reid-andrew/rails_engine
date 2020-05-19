FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { Faker::Number.non_zero_digit }
    unit_price { Faker::Number.positive }
  end
end
