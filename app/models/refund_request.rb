class RefundRequest < ApplicationRecord
  self.table_name = "remboursements"

  # Associations
  belongs_to :bill_of_lading, class_name: "BillOfLading", foreign_key: "numero_bl", primary_key: "numero_bl"
  belongs_to :customer, class_name: "Customer", foreign_key: "consignee_code", primary_key: "code_client"
end
