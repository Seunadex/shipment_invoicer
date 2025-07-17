# == Schema Information
#
# Table name: bls
#
#  id                         :bigint           not null, primary key
#  id_upload                  :bigint
#  upload_date                :datetime
#  number                     :string(9)        not null
#  customer_id                :bigint
#  consignee_code             :string(20)
#  consignee_name             :string(60)
#  notified_code              :string(20)
#  notified_name              :string(60)
#  vessel_name                :string(30)
#  vessel_voyage              :string(10)
#  arrival_date               :datetime
#  freetime                   :integer
#  quantity_dry_20ft          :integer
#  quantity_dry_40ft          :integer
#  quantity_refrigerated_20ft :integer
#  quantity_refrigerated_40ft :integer
#  quantity_special_20ft      :integer
#  quantity_special_40ft      :integer
#  reef                       :string(1)        default("")
#  unloading_type             :string(30)
#  validity_date              :datetime
#  status                     :string(30)
#  exempt                     :boolean          default(FALSE), not null
#  blocked_for_refund         :boolean          default(FALSE), not null
#  reference                  :string(60)
#  comment                    :text(65535)
#  valid_flag                 :boolean
#  released_status            :string(20)
#  released_notes             :text(65535)
#  operator                   :string(20)
#  atp                        :string(30)
#  consignee_caution          :boolean          default(FALSE), not null
#  service_contract           :string(200)
#  bank_account               :string(30)
#  bank_name                  :string(30)
#  emails                     :string(60)
#  telephone                  :string(20)
#  receipt_location           :string(60)
#  delivery_location          :string(60)
#  loading_port               :string(60)
#  discharge_port             :string(60)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
class BillOfLading < ApplicationRecord
  self.table_name = "bls"

  # Associations
  belongs_to :customer, class_name: "Customer", foreign_key: "customer_id", primary_key: "id"
  has_many :invoices, class_name: "Invoice", foreign_key: "number", primary_key: "number"
  has_many :refund_requests, class_name: "RefundRequest", foreign_key: "number", primary_key: "number"
end
