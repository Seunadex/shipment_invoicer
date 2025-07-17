class InvoicesController < ApplicationController
  def overdue
    overdue_invoices = Invoice.overdue
    render json: overdue_invoices
  end
end
