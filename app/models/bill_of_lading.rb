class BillOfLading < ApplicationRecord
  self.table_name = "bls"

  # Associations
  belongs_to :customer, class_name: "Customer", foreign_key: "customer_id", primary_key: "id"
  has_many :invoices, class_name: "Invoice", foreign_key: "number", primary_key: "number"
  has_many :refund_requests, class_name: "RefundRequest", foreign_key: "number", primary_key: "number"
end
