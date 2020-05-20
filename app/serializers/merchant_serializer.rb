class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :created_at, :updated_at
  attribute :total_revenue, if: Proc.new { |record, params|
    params && params[:revenue] == true
  }
  attribute :total_items, if: Proc.new { |record, params|
    params && params[:items] == true
  }
  has_many :item
end
