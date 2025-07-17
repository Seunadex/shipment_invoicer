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
require "rails_helper"

RSpec.describe Customer, type: :model do
  describe "database table mapping" do
    it "should map to the 'clients' table" do
      expect(described_class.table_name).to eq("clients")
    end

    it "uses id as primary key" do
      expect(described_class.primary_key).to eq("id")
    end
  end

  describe "associations" do
    it { is_expected.to have_many(:bills_of_lading).class_name("BillOfLading").with_foreign_key("customer_id") }
    it { is_expected.to have_many(:invoices).through(:bills_of_lading).source(:invoices) }
    it { is_expected.to have_many(:refund_requests).through(:bills_of_lading).source(:refund_requests) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(60) }

    it { is_expected.to validate_presence_of(:group_name) }
    it { is_expected.to validate_length_of(:group_name).is_at_most(150) }

    it { is_expected.to validate_length_of(:client_code).is_at_most(20) }
  end
end
