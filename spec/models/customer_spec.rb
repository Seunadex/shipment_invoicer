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
end
