class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  set_type :merchant
  attributes :id, :name, :created_at, :updated_at
  has_many :item
end
