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
require "rails_helper"

RSpec.describe Invoice, type: :model do
  describe "database table mapping" do
    it "should map to the 'factures' table" do
      expect(described_class.table_name).to eq("factures")
    end

    it "uses id as primary key" do
      expect(described_class.primary_key).to eq("id")
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:bill_of_lading).class_name("BillOfLading").with_foreign_key("number") }
    it { is_expected.to belong_to(:customer).class_name("Customer").with_foreign_key("client_code") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:reference) }
    it { is_expected.to validate_length_of(:reference).is_at_most(10) }

    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_length_of(:number).is_at_most(9) }

    it { is_expected.to validate_presence_of(:client_code) }
    it { is_expected.to validate_length_of(:client_code).is_at_most(20) }

    it { is_expected.to validate_presence_of(:client_name) }
    it { is_expected.to validate_length_of(:client_name).is_at_most(60) }

    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_numericality_of(:original_amount).is_greater_than_or_equal_to(0).allow_nil }

    it { is_expected.to validate_length_of(:currency).is_at_most(6) }

    it { is_expected.to validate_presence_of(:invoice_date) }
  end
end
