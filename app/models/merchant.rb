class  Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def self.most_revenue(quantity)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .joins(:invoice_items, :transactions)
    .merge(Transaction.successful)
    .group(:id)
    .order("total_revenue DESC")
    .limit(quantity)
  end

  def self.most_items(quantity)
    select('merchants.*, SUM(invoice_items.quantity) AS total_items')
    .joins(:invoice_items, :transactions)
    .merge(Transaction.successful)
    .group(:id)
    .order("total_items DESC")
    .limit(quantity)
  end

  def self.revenue(id)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .joins(:invoice_items, :transactions)
    .merge(Transaction.successful)
    .where("merchants.id = #{id}")
    .group(:id)
  end
end
