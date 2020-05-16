require 'rails_helper'

RSpec.describe 'Merchants API Endpoints - ', type: :request do
  it 'returns merchants index' do
    create_list(:merchant, 3)
    get '/api/v1/merchants'
    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants["data"].count).to eq(3)
  end

  it 'returns merchants show record' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(id.to_s)
  end

  it 'creates merchant record' do
    params = {name: Faker::Appliance.unique.equipment}

    post "/api/v1/merchants", params: params
    response_merchant = JSON.parse(response.body)
    merchant = Merchant.last

    expect(response).to be_successful
    expect(merchant[:name]).to eq(params[:name])
    expect(response_merchant["data"]["attributes"]["name"]).to eq(params[:name])
  end

  it 'updates merchant record' do
    merchant = create(:merchant)
    orig_name = merchant[:name]
    update_parms = {name: Faker::Movies::Lebowski.character}

    put "/api/v1/merchants/#{merchant.id}", params: update_parms
    updated_merchant = Merchant.find(merchant.id)
    response_merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(updated_merchant.name).to_not eq(orig_name)
    expect(updated_merchant.name).to eq(update_parms[:name])
    expect(response_merchant["data"]["attributes"]["name"]).to_not eq(orig_name)
    expect(response_merchant["data"]["attributes"]["name"]).to eq(update_parms[:name])
  end

  it 'destroys merchant record' do
    create_list(:merchant, 3)
    merchant = Merchant.last

    expect(Merchant.count).to eq(3)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful
    expect(Merchant.count).to eq(2)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
