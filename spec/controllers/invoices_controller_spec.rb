

require 'rails_helper'

RSpec.describe InvoicesController, type: :controller do
  describe "GET #overdue" do
  let!(:customer) { create(:customer) }
    let!(:bl) { create(:bill_of_lading, customer: customer) }
    let!(:invoice1) { create(:invoice, bill_of_lading: bl, invoice_date: 3.days.ago) }
    let!(:invoice2) { create(:invoice, bill_of_lading: bl, invoice_date: 1.day.ago) }

    before do
      allow(Invoice).to receive(:overdue).and_return([ invoice1, invoice2 ])
    end

    context "when requesting HTML format" do
      it "renders the overdue template" do
        get :overdue
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:overdue)
      end
    end

    context "when requesting JSON format" do
      it "returns JSON with the list of overdue invoices" do
        get :overdue, format: :json
        expect(response).to have_http_status(:success)
        json = JSON.parse(response.body)
        expect(json.length).to eq(2)
        expect(json.first["id"]).to eq(invoice1.id)
      end
    end
  end
end
