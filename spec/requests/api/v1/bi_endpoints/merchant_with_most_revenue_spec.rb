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

    it 'finds correct number of merchants' do
      get '/api/v1/merchants/most_revenue?quantity=1'
      expected = JSON.parse(response.body)

      expect(response).to be_successful
      expect(expected["data"].size).to eq(1)

      get '/api/v1/merchants/most_revenue?quantity=2'
      expected = JSON.parse(response.body)

      expect(response).to be_successful
      expect(expected["data"].size).to eq(2)

      get '/api/v1/merchants/most_revenue?quantity=9'
      expected = JSON.parse(response.body)

      expect(response).to be_successful
      expect(expected["data"].size).to eq(5)
    end

    it 'finds a list of merchants in revenue order' do
      get '/api/v1/merchants/most_revenue?quantity=5'
      expected = JSON.parse(response.body)
      first_number_one = expected["data"][0]
      first_number_two = expected["data"][1]

      expect(response).to be_successful
      expect(expected["data"].size).to eq(5)
      expect(expected["data"][0]["attributes"]["total_revenue"]).to be > (expected["data"][1]["attributes"]["total_revenue"])
      expect(expected["data"][1]["attributes"]["total_revenue"]).to be > (expected["data"][2]["attributes"]["total_revenue"])
      expect(expected["data"][2]["attributes"]["total_revenue"]).to be > (expected["data"][3]["attributes"]["total_revenue"])
      expect(expected["data"][3]["attributes"]["total_revenue"]).to be > (expected["data"][4]["attributes"]["total_revenue"])

      get '/api/v1/merchants/most_revenue?quantity=3'
      expected = JSON.parse(response.body)
      second_number_one = expected["data"][0]
      second_number_two = expected["data"][1]

      expect(first_number_one["id"]).to eq(second_number_one["id"])
      expect(first_number_two["id"]).to eq(second_number_two["id"])
    end

    it 'excludes unpaid invoices' do
      new_item = create(:invoice_item)
      new_item.invoice.transactions.create(
          credit_card_number: Faker::Number.number(digits: 16),
          credit_card_expiration_date: Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :all),
          result: 'failed'
      )
      new_merchant = new_item.invoice.merchant

      get '/api/v1/merchants/most_revenue?quantity=6'
      expected = JSON.parse(response.body)

      expect(response).to be_successful
      expect(expected["data"].size).to eq(5)
      expect(expected["data"][0]["id"]).to_not eq(new_merchant.id)
      expect(expected["data"][1]["id"]).to_not eq(new_merchant.id)
      expect(expected["data"][2]["id"]).to_not eq(new_merchant.id)
      expect(expected["data"][3]["id"]).to_not eq(new_merchant.id)
      expect(expected["data"][4]["id"]).to_not eq(new_merchant.id)
    end
  end
end
