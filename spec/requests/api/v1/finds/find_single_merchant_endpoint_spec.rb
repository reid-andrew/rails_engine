require 'rails_helper'

RSpec.describe 'Find Single Merchant API Endpoint - ', type: :request do
  it 'finds a single merchant by name' do
    create_list(:merchant, 3)
    expected = Merchant.create(name: 'Turing')
    create_list(:merchant, 3)

    get '/api/v1/merchants/find?name=ring'
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(expected.id.to_s)
  end

  it 'finds a single merchant by created date' do
    create_list(:merchant, 3)
    get "/api/v1/merchants/find?created_at=#{Time.zone.now}"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(Merchant.first.id.to_s)
  end

  it 'finds a single merchant by multiple criteria' do
    create_list(:merchant, 3)
    expected = Merchant.create(name: 'Turing')
    create_list(:merchant, 3)
    get "/api/v1/merchants/find?name=ring&created_at=#{Date.today}"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(expected.id.to_s)
  end

  it 'returns the first merchant when multiple merchants meet the criteria' do
    create_list(:merchant, 3)
    expected = Merchant.create(name: 'Turing')
    Merchant.create(name: 'Boring')
    create_list(:merchant, 3)
    Merchant.create(name: 'Ring Central')

    get '/api/v1/merchants/find?name=ring'
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(expected.id.to_s)
  end

  it 'finds a single merchant in a case insensitive manner' do
    create_list(:merchant, 3)
    expected = Merchant.create(name: 'TuRiNg')
    create_list(:merchant, 3)

    get '/api/v1/merchants/find?name=rInG'
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(expected.id.to_s)
  end

  it 'handles no results provided' do
    Merchant.create(name: 'Grateful Dead')
    Merchant.create(name: 'Pink Floyd')
    Merchant.create(name: 'The Clash')

    get '/api/v1/merchants/find?name=ring'
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]).to eq(nil)
  end
end
