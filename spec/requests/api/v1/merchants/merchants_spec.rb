require 'rails_helper'

RSpec.describe 'Merchants API Endpoints - ', type: :request do
  it 'returns merchants index' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'
    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants.count).to eq(3)
  end

end
