# == Schema Information
#
# Table name: remboursements
#
#  id                    :bigint           not null, primary key
#  number                :string(9)        not null
#  requested_amount      :string(15)
#  refund_amount         :string(15)
#  deduction             :string(15)
#  status                :string(10)       default("PENDING")
#  id_transitaire        :bigint           not null
#  id_transitaire_maison :bigint
#  transitaire_notifie   :boolean
#  maison_notifie        :boolean
#  banque_notifie        :boolean
#  date_demande          :datetime
#  date_refund_traite    :datetime
#  type_paiement         :string(10)
#  pret                  :string(10)
#  soumis                :string(10)
#  consignee_code        :string(14)
#  refund_party_name     :string(200)
#  beneficiaire          :string(20)
#  deposit_amount        :string(15)
#  refund_reason         :string(200)
#  remarks               :string(250)
#  co_code               :string(20)
#  zm_doc_no             :text(65535)
#  gl_posting_doc        :string(15)
#  clearing_doc          :string(15)
#  email_address         :string(60)
#  type_depotage         :string(40)
#  accord_client         :boolean
#  comment               :text(65535)
#  reference             :string(30)
#  date_agent_notified   :datetime
#  date_agency_notified  :datetime
#  date_client_notified  :datetime
#  date_banque_notified  :datetime
#  email_agency          :string(60)
#  email_client          :string(60)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class RefundRequest < ApplicationRecord
  self.table_name = "remboursements"

  # Associations
  belongs_to :bill_of_lading, class_name: "BillOfLading", foreign_key: "number", primary_key: "number"
  belongs_to :customer, class_name: "Customer", foreign_key: "consignee_code", primary_key: "client_code"

  # Validations
  validates :number, presence: true, length: { maximum: 9 }
  validates :requested_amount, length: { maximum: 15 }
  validates :refund_amount, length: { maximum: 15 }
  validates :deduction, length: { maximum: 15 }
  validates :status, presence: true, length: { maximum: 10 }

  enum status: { pending: "PENDING", processed: "PROCESSED", rejected: "REJECTED" }
end
