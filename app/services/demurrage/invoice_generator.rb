module Demurrage
  class InvoiceGenerator < BaseService
    DEMURRAGE_RATE = 80

    def call
      invoices = []
      overdue_bills = BillOfLading.overdue_today
      return invoices if overdue_bills.empty?

      overdue_bills.each do |bl|
        next unless bl.eligible_for_invoice?
        next if bl.invoices.unpaid.exists?

        container_count = bl.container_count
        next if container_count.zero?

        amount = container_count * DEMURRAGE_RATE
        next if amount <= 0

        invoice = create_invoice_for(bl, amount)

        invoices << invoice
      end

      invoices
    rescue StandardError => e
      Rails.logger.error("Error generating demurrage invoices: #{e.message}")
      raise e
    end

    private

    def generate_reference
      "INV#{SecureRandom.hex(2).upcase}"
    end

    def create_invoice_for(bill_of_lading, amount)
      Invoice.create!(
        reference: generate_reference,
        number: bill_of_lading.number,
        client_code: bill_of_lading.customer.client_code,
        client_name: bill_of_lading.customer.name,
        amount: amount,
        original_amount: amount,
        currency: "XOF",
        status: "init",
        invoice_date: Date.current,
        user_id: 1
      )
    end
  end
end
