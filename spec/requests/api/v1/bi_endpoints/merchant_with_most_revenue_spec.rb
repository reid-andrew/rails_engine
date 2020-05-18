require 'rails_helper'

RSpec.describe 'Business Intelligence API Endpoint - ', type: :request do
  describe 'Merchants with Most Revenue - ' do
    before (:each) do
      create_list(:invoice_item, 10)
    end

    it 'finds single merchant' do
      get '/api/v1/merchants/most_revenue?quantity=1'
      merchants = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchants["data"].size).to eq(1)
    end

  end
end
