class  Merchant < ApplicationRecord
  has_many :items

  validates :name, presence: true

  def self.most_revenue(quantity)
    sql =  "SELECT m.*, SUM(i.revenue) AS total_revenue
            FROM merchants m
            INNER JOIN (
                SELECT invoices.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue
                FROM invoices
                INNER JOIN invoice_items ON invoice_items.invoice_id = invoices.id
                INNER JOIN transactions ON transactions.invoice_id = invoices.id
                WHERE transactions.result = 'success'
                GROUP BY invoices.id) i
            ON m.id = i.merchant_id
            GROUP BY m.id
            ORDER BY total_revenue DESC
            LIMIT(#{quantity});"
    Merchant.find_by_sql(sql)

    # inv_totals = Invoice.select('invoices.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    # .joins(:invoice_items, :transactions)
    # .merge(Transaction.successful)
    # .group(:id)
    #
    # Merchant.select('merchants.*, SUM(inv_totals.revenue) AS total_revenue')
    # .joins(inv_totals)
    # .group(:id)
    # .order("total_revenue")
    # .limit(quantity)
  end
end
