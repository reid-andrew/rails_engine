class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :transactions, through: :invoice

  validates :quantity, presence: true
  validates :unit_price, presence: true
end
