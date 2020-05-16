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
  end

  def data_load(model, file)
    require 'csv'
    path = File.join Rails.root, 'db', 'seed_data'
    csv_text = File.read(File.join(path, file))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      model.create!(row.to_hash)
    end
  end
end
