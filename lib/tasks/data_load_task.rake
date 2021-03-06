namespace :db do
  desc "Reset database and load seeds from csv files"
  task :reload => :environment do
    Rake::Task['db:migrate:reset'].invoke
    data_load(Customer, 'customers.csv')
    data_load(Merchant, 'merchants.csv')
    data_load(Item, 'items.csv')
    data_load(Invoice, 'invoices.csv')
    data_load(InvoiceItem, 'invoice_items.csv')
    data_load(Transaction, 'transactions.csv')
    ActiveRecord::Base.connection.tables.each do |table|
      ActiveRecord::Base.connection.reset_pk_sequence!(table)
    end
  end

  def data_load(model, file)
    require 'csv'
    path = File.join Rails.root, 'db', 'seed_data'
    csv_text = File.read(File.join(path, file))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      row["unit_price"] = (row["unit_price"].to_f / 100).to_s if row["unit_price"]
      model.create!(row.to_hash)
    end
  end
end
