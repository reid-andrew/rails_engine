require 'rails_helper'

RSpec.describe 'Business Intelligence API Endpoint - ', type: :request do
  describe 'Merchants with Most Revenue - ' do
    before (:each) do
      inv_items = create_list(:invoice_item, 10)
      inv_items.each do |item|
        item.invoice.transactions.create(
          credit_card_number: Faker::Number.number(digits: 16),
          credit_card_expiration_date: Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :all),
          result: 'success')
          # result: ['success', 'failed'].sample)
      end
    end

    it 'finds single merchant' do
      get '/api/v1/merchants/most_revenue?quantity=1'
      expected = JSON.parse(response.body)

      expect(response).to be_successful
      expect(expected["data"].size).to eq(1)
    end

  end
end
