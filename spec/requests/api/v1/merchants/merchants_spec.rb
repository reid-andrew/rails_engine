require 'rails_helper'

RSpec.describe 'Merchants API Endpoints - ', type: :request do
  it 'returns merchants index' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'
    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants.count).to eq(3)
  end

  it 'returns merchants show record' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"
    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["id"]).to eq(id)
  end

  it 'creates merchant record' do
    params = {name: Faker::Appliance.unique.equipment}

    post "/api/v1/merchants", params: params
    merchant = Merchant.last

    expect(response).to be_successful
    expect(merchant.name).to eq(params[:name])
  end

  it 'updates merchant record' do
    merchant = create(:merchant)
    orig_name = merchant[:name]
    update_parms = {name: Faker::Movies::Lebowski.character}

    put "/api/v1/merchants/#{merchant.id}", params: update_parms
    updated_merchant = Merchant.find(merchant.id)

    expect(response).to be_successful
    expect(updated_merchant.name).to_not eq(orig_name)
    expect(updated_merchant.name).to eq(update_parms[:name])
  end
end
