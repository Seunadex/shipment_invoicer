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
end
