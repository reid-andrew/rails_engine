require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it {should validate_presence_of(:name)}
  end

  describe 'class methods' do
    before (:each) do
      inv_items = create_list(:invoice_item, 5)
      inv_items.each do |item|
        item.invoice.transactions.create(
          credit_card_number: Faker::Number.number(digits: 16),
          credit_card_expiration_date: Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :all),
          result: 'success')
      end
    end
    it '.most_revenue' do
      top_one = Merchant.most_revenue(1)
      top_three = Merchant.most_revenue(3)
      top_five = Merchant.most_revenue(5)

      expect(top_one[1]).to be nil
      expect(top_one[0]).to eq(top_three[0])
      expect(top_one[0]).to eq(top_five[0])
      expect(top_three[2]).to eq(top_five[2])
      expect(top_three[3]).to be nil
      expect(top_five[5]).to be nil
    end

    it '.most_items' do
      top_one = Merchant.most_items(1)
      top_three = Merchant.most_items(3)
      top_five = Merchant.most_items(5)
      
      expect(top_one[1]).to be nil
      expect(top_one[0]).to eq(top_three[0])
      expect(top_one[0]).to eq(top_five[0])
      expect(top_three[2]).to eq(top_five[2])
      expect(top_three[3]).to be nil
      expect(top_five[5]).to be nil
    end
  end
end
