class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  set_type :merchant
  attributes :id, :name, :created_at, :updated_at
  attribute :total_revenue, if: Proc.new { |record, params|
    params && params[:revenue] == true
  }
  has_many :item
end
