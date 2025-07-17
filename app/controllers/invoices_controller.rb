class InvoicesController < ApplicationController
  def overdue
    @overdue_invoices = Invoice.overdue
    respond_to do |format|
      format.html
      format.json { render json: @overdue_invoices }
    end
  end
end
