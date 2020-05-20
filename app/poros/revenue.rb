class Revenue

  def self.revenue_across_dates(start_date, end_date)
    InvoiceItem.select('SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
               .joins(:transactions)
               .merge(Transaction.successful)
               .where(created_at: Date.parse(start_date).beginning_of_day...Date.parse(end_date).end_of_day)
  end
end
