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
require "rails_helper"

RSpec.describe RefundRequest, type: :model do
  describe "database table mapping" do
    it "should map to the 'remboursements' table" do
      expect(described_class.table_name).to eq("remboursements")
    end

    it "uses id as primary key" do
      expect(described_class.primary_key).to eq("id")
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:bill_of_lading).class_name("BillOfLading").with_foreign_key("number") }
    it { is_expected.to belong_to(:customer).class_name("Customer").with_foreign_key("consignee_code") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_length_of(:number).is_at_most(9) }

    it { is_expected.to validate_length_of(:requested_amount).is_at_most(15) }
    it { is_expected.to validate_length_of(:refund_amount).is_at_most(15) }
    it { is_expected.to validate_length_of(:deduction).is_at_most(15) }

  end
end
