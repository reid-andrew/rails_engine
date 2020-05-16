class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  set_type :merchant
  attributes :name, :created_at, :updated_at
  has_many :item
end
