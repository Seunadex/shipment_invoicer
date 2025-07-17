# == Schema Information
#
# Table name: factures
#
#  id                      :bigint           not null, primary key
#  reference               :string(10)       not null
#  number                  :string(9)        not null
#  client_code             :string(20)       not null
#  client_name             :string(60)       not null
#  amount                  :decimal(12, )    not null
#  original_amount         :decimal(12, 2)
#  currency                :string(6)        default("XOF")
#  status                  :string(10)       default("init"), not null
#  invoice_date            :datetime         not null
#  user_id                 :bigint           not null
#  create_type_utilisateur :string(20)
#  id_utilisateur_update   :bigint
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class Invoice < ApplicationRecord
  self.table_name = "factures"

  # Associations
  belongs_to :bill_of_lading, class_name: "BillOfLading", foreign_key: "number", primary_key: "number"
  belongs_to :customer, class_name: "Customer", foreign_key: "client_code", primary_key: "client_code"
end
