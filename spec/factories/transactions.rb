FactoryBot.define do
  factory :invoice_item do
    invoice
    credit_card_number { Faker::Number.number(digits: 16) }
    credit_card_expiration_date { Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :all) }
    result { ['success', 'failed'].sample }
  end
end
