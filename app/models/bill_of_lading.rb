class BillOfLading < ApplicationRecord
  self.table_name = "bls"

  # Associations
  belongs_to :customer, class_name: "Customer", foreign_key: "id_client", primary_key: "id"
  has_many :invoices, class_name: "Invoice", foreign_key: "numero_bl", primary_key: "numero_bl"
  has_many :refund_requests, class_name: "RefundRequest", foreign_key: "numero_bl", primary_key: "numero_bl"
end
