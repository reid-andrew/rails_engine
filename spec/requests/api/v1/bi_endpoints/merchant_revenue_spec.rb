require 'rails_helper'

RSpec.describe 'Business Intelligence API Endpoint - ', type: :request do
  describe 'Merchant revenue - ' do
    before (:each) do
      inv_items = create_list(:invoice_item, 5)
      inv_items.each do |item|
        item.invoice.transactions.create(
          credit_card_number: Faker::Number.number(digits: 16),
          credit_card_expiration_date: Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :all),
          result: 'success')
      end
    end

    it 'finds revenue for a given merchant' do
      merchant = InvoiceItem.first.invoice.merchant
      get "/api/v1/merchants/#{merchant.id}/revenue"
      expected = JSON.parse(response.body)

      expect(response).to be_successful
      expect(expected["data"].size).to eq(1)
      expect(expected["data"][0]["attributes"]["revenue"].class).to eq(Float)
      expect(expected["data"][0]["attributes"]["revenue"]).to be > (0)

      merchant = InvoiceItem.last.invoice.merchant
      get "/api/v1/merchants/#{merchant.id}/revenue"
      expected = JSON.parse(response.body)

      expect(response).to be_successful
      expect(expected["data"].size).to eq(1)
      expect(expected["data"][0]["attributes"]["revenue"].class).to eq(Float)
      expect(expected["data"][0]["attributes"]["revenue"]).to be > (0)
    end
  end
end
