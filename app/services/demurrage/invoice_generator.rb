module Demurrage
  class InvoiceGenerator < BaseService
    DEMURRAGE_RATE = 80

    def call
      invoices = []
      overdue_bills = BillOfLading.overdue_today
      return invoices if overdue_bills.empty?

      overdue_bills.each do |bl|
        next if bl.invoices.unpaid.exists?

        container_count = bl.container_count
        next if container_count.zero?

        amount = container_count * DEMURRAGE_RATE
        next if amount <= 0

        invoice = Invoice.create!(
          reference: generate_reference,
          number: bl.number,
          client_code: bl.customer.client_code,
          client_name: bl.customer.name,
          amount: amount,
          original_amount: amount,
          currency: "XOF",
          status: "init",
          invoice_date: Date.current,
          user_id: 1
        )

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
  end
end
