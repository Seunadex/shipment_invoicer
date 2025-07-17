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

  # Validations
  validates :reference, presence: true, length: { maximum: 10 }
  validates :number, presence: true, length: { maximum: 9 }
  validates :client_code, presence: true, length: { maximum: 20 }
  validates :client_name, presence: true, length: { maximum: 60 }
  validates :amount, presence: true
  validates :original_amount, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :currency, length: { maximum: 6 }
  validates :status, presence: true, length: { maximum: 10 }
  validates :invoice_date, presence: true

  enum status: { init: "init", paid: "paid" }

  scope :unpaid, -> { where(status: "init") }
end
