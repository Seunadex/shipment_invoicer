require "rails_helper"

RSpec.describe Demurrage::InvoiceGenerator, type: :service do
  describe "#call" do
  context "when there are overdue Bill of Lading records" do
    let!(:customer) { create(:customer, client_code: "CUST001", name: "Test Customer") }
      let!(:bill_of_lading) { create(:bill_of_lading, status: "pending", arrival_date: 2.days.ago, freetime: 2, customer: customer) }

      before do
        allow(BillOfLading).to receive(:overdue_today).and_return([ bill_of_lading ])
      end

      it "generates an invoice for the overdue Bill of Lading" do
        expect { described_class.call }.to change(Invoice, :count).by(1)

        invoice = Invoice.last
        expect(invoice.number).to eq(bill_of_lading.number)
        expect(invoice.client_code).to eq(customer.client_code)
        expect(invoice.status).to eq("init")
      end
    end
  end

  context "when there are no overdue Bill of Lading records" do
    before do
      allow(BillOfLading).to receive(:overdue_today).and_return([])
    end

    it "does not generate any invoices" do
      expect { described_class.call }.not_to change(Invoice, :count)
    end
  end
end
