require 'rails_helper'

RSpec.describe 'Business Intelligence API Endpoint - ', type: :request do
  describe 'Merchants with Most Revenue - ' do
    before (:each) do
      inv_items = create_list(:invoice_item, 5)
      inv_items.each do |item|
        item.invoice.transactions.create(
          credit_card_number: Faker::Number.number(digits: 16),
          credit_card_expiration_date: Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :all),
          result: 'success')
      end
    end

    it 'finds revenue for a date range' do
      total_revenue = InvoiceItem.sum do |item|
        item.quantity * item.unit_price
      end

      get "/api/v1/revenue?start=#{Date.today - 5}&end=#{Date.today + 5}"
      expected = JSON.parse(response.body)

      expect(response).to be_successful
      expect(expected["data"].size).to eq(1)
      expect(expected["data"][0]["attributes"]["revenue"].round(2)).to eq(total_revenue.round(2))
    end
  end
end
