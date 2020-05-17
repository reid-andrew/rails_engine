require 'rails_helper'

RSpec.describe 'Find Multiple Merchants API Endpoint - ', type: :request do
  it 'finds a multiple merchant by name' do
    create_list(:merchant, 3)
    expected_1 = Merchant.create(name: 'Turing')
    create_list(:merchant, 2)
    expected_2 = Merchant.create(name: 'Boring')
    create_list(:merchant, 2)
    expected_3 = Merchant.create(name: 'Ring Central')
    create_list(:merchant, 3)

    get '/api/v1/merchants/find_all?name=ring'
    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants["data"].size).to eq(3)
    expect(merchants["data"][0]["id"]).to eq(expected_1.id.to_s)
    expect(merchants["data"][1]["id"]).to eq(expected_2.id.to_s)
    expect(merchants["data"][2]["id"]).to eq(expected_3.id.to_s)
    expect(merchants["data"][0]["attributes"]["name"]).to eq(expected_1.name)
    expect(merchants["data"][1]["attributes"]["name"]).to eq(expected_2.name)
    expect(merchants["data"][2]["attributes"]["name"]).to eq(expected_3.name)
  end

  it 'handles no results provided' do
    Merchant.create(name: 'Turing')

    get '/api/v1/merchants/find_all?name=nope'
    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants["data"]).to eq([])
  end

end
