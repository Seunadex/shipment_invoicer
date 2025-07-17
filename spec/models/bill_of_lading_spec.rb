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
require "rails_helper"

RSpec.describe BillOfLading, type: :model do
  describe "database table mapping" do
    it "should map to the 'bls' table" do
      expect(described_class.table_name).to eq("bls")
    end

    it "use id as primary key" do
      expect(described_class.primary_key).to eq("id")
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:customer).class_name("Customer").with_foreign_key("customer_id") }
    it { is_expected.to have_many(:invoices).class_name("Invoice").with_foreign_key("number") }
    it { is_expected.to have_many(:refund_requests).class_name("RefundRequest").with_foreign_key("number") }
  end
end
