class  Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices


  validates :name, presence: true

  def self.most_revenue(quantity)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .joins(:invoices, :invoice_items, :transactions)
    .merge(Transaction.successful)
    .group(:id)
    .order("total_revenue DESC")
    .limit(quantity)

    # sql =  "SELECT m.*, SUM(s.quantity * s.unit_price) as total_revenue
    #         FROM merchants m
    #         INNER JOIN invoices i ON m.id = i.merchant_id
    #         INNER JOIN invoice_items s ON s.invoice_id = i.id
    #         INNER JOIN transactions t ON t.invoice_id = i.id
    #         WHERE t.result = 'success'
    #         GROUP BY m.id
    #         ORDER BY total_revenue DESC
    #         LIMIT(#{quantity});"
    # Merchant.find_by_sql(sql)
  end

  def self.most_items(quantity)
    select('merchants.*, SUM(invoice_items.quantity) AS total_items')
    .joins(:invoices, :invoice_items, :transactions)
    .merge(Transaction.successful)
    .group(:id)
    .order("total_items DESC")
    .limit(quantity)
  end

  def self.revenue(id)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .joins(:invoices, :invoice_items, :transactions)
    .merge(Transaction.successful)
    .where("merchants.id = #{id}")
    .group(:id)
  end
end
