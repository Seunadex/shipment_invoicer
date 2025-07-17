module Api
  module Invoices
    class GenerationController < Api::BaseController
      def create
        invoices = Demurrage::InvoiceGenerator.new.call
        render json: invoices, status: :created
      rescue StandardError => e
        Rails.logger.error("Error generating invoices: #{e.message}")
        render json: { error: "Failed to generate invoices" }, status: :internal_server_error
      end
    end
  end
end
