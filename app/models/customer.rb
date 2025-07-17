class Customer < ApplicationRecord
  self.table_name = "clients"

  # Associations
  has_many :bills_of_lading, class_name: "BillOfLading", foreign_key: "customer_id", primary_key: "id"
  has_many :invoices, through: :bills_of_lading, source: :invoices
  has_many :refund_requests, through: :bills_of_lading, source: :refund_requests
end
