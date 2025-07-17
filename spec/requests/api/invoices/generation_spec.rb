require 'rails_helper'

RSpec.describe "POST /api/invoices/generate_overdue", type: :request do
  describe "invoice generation" do
    it "generates a new invoice for overdue BLs" do
       bl = create(:bill_of_lading, arrival_date: 5.days.ago, freetime: 5)
      create(:invoice, bill_of_lading: bl, status: "paid") # previously paid invoice

      # Ensure no unpaid invoice exists for this BL
      expect(bl.invoices.unpaid).to be_empty

      expect {
        post "/api/invoices/generate_overdue"
      }.to change { Invoice.count }.by(1)

      expect(response).to have_http_status(:created)

      body = JSON.parse(response.body)
      expect(body).to be_an(Array)
      expect(body.first["number"]).to eq(bl.number)
    end

    it "skips BLs that already have an open (unpaid) invoice" do
       bl = create(:bill_of_lading, arrival_date: 5.days.ago, freetime: 5)
      create(:invoice, bill_of_lading: bl, status: "init")

      expect(bl.invoices.unpaid).not_to be_empty

      expect {
        post "/api/invoices/generate_overdue"
      }.not_to change { Invoice.count }

      expect(response).to have_http_status(:created)
      body = JSON.parse(response.body)
      expect(body).to eq([])
    end
  end
end
