class Invoice < ApplicationRecord
  self.table_name = "factures"

  # Associations
  belongs_to :bill_of_lading, class_name: "BillOfLading", foreign_key: "numero_bl", primary_key: "numero_bl"
  belongs_to :customer, class_name: "Customer", foreign_key: "code_client", primary_key: "code_client"
end
