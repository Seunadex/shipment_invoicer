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
    it { is_expected.to belong_to(:customer).class_name("Customer").with_foreign_key("id_client") }
    it { is_expected.to have_many(:invoices).class_name("Invoice").with_foreign_key("numero_bl") }
    it { is_expected.to have_many(:refund_requests).class_name("RefundRequest").with_foreign_key("numero_bl") }
  end
end
