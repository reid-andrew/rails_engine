class Revenue
  def self.revenue_across_dates(start_date, end_date)
    rev_by_inv = Invoice.select('invoices.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .joins(:invoice_items, :transactions)
    .merge(Transaction.successful)
    .where(created_at: Date.parse(start_date).beginning_of_day...Date.parse(end_date).end_of_day)
    .group(:id)

    rev_by_inv.sum { |invoice| invoice.revenue }
  end
end
