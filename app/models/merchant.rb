class  Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  validates :name, presence: true

  def self.most_revenue(quantity)
    sql =  "SELECT m.*, SUM(s.quantity * s.unit_price) as total_revenue
            FROM merchants m
            INNER JOIN invoices i ON m.id = i.merchant_id
            INNER JOIN invoice_items s ON s.invoice_id = i.id
            INNER JOIN transactions t ON t.invoice_id = i.id
            WHERE t.result = 'success'
            GROUP BY m.id
            ORDER BY total_revenue DESC
            LIMIT(#{quantity});"
    Merchant.find_by_sql(sql)

    # select('merchant.*, SUM(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
    # .joins(:invoices)
    # .joins(:invoice_items, :transactions)
    # .merge(Transaction.successful)
    # .group(:id)
    # .order("total_revenue")
    # .limit(quantity)
  end
end
