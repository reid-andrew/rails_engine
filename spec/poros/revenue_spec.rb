require 'rails_helper'

RSpec.describe Revenue, type: :feature do
  it 'calculates revenue' do
    inv_items = create_list(:invoice_item, 5)
    inv_items.each do |item|
      item.invoice.transactions.create(
        credit_card_number: Faker::Number.number(digits: 16),
        credit_card_expiration_date: Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :all),
        result: 'success')
    end

    total_revenue = InvoiceItem.sum do |item|
      item.quantity * item.unit_price
    end
    start_date = Date.today - 2
    end_date = Date.today + 2
    expected = Revenue.revenue_across_dates(start_date.to_s, end_date.to_s)

    expect(expected).to eq(total_revenue)
  end
end
