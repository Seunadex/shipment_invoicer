# == Schema Information
#
# Table name: clients
#
#  id                    :bigint           not null, primary key
#  name                  :string(60)       not null
#  status                :string(20)
#  client_code           :string(20)
#  group_name            :string(150)      not null
#  deposit_required      :boolean          not null
#  freetime_refrigerated :integer
#  freetime_dry          :integer
#  priority              :boolean
#  sales_rep_id          :bigint
#  finance_rep_id        :bigint
#  cservice_rep_id       :bigint
#  validity_date         :datetime
#  operator              :string(20)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class Customer < ApplicationRecord
  self.table_name = "clients"

  # Associations
  has_many :bills_of_lading, class_name: "BillOfLading", foreign_key: "customer_id", primary_key: "id"
  has_many :invoices, through: :bills_of_lading, source: :invoices
  has_many :refund_requests, through: :bills_of_lading, source: :refund_requests
end
