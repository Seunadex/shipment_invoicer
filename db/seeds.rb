# Clear existing data
Invoice.delete_all
RefundRequest.delete_all
BillOfLading.delete_all
Customer.delete_all

# Seed data for customers
clients = 5.times.map do |i|
  Customer.create!(
    name: Faker::Company.name,
    status: %w[active inactive].sample,
    client_code: "C#{1000 + i}",
    group_name: Faker::Company.suffix,
    deposit_required: [ true, false ].sample,
    freetime_refrigerated: rand(5..15),
    freetime_dry: rand(5..10),
    priority: [ true, false ].sample,
    sales_rep_id: nil,
    finance_rep_id: nil,
    cservice_rep_id: nil,
    validity_date: Faker::Date.forward(days: 90),
    operator: Faker::Name.first_name[0..19]
  )
end

# 1. BL with no containers
BillOfLading.create!(
  number: "BLZERO",
  customer: clients.first,
  vessel_name: "NOCARGO",
  vessel_voyage: "VY00",
  arrival_date: Date.today - 10,
  freetime: 5,
  quantity_dry_20ft: 0,
  quantity_dry_40ft: 0,
  quantity_refrigerated_20ft: 0,
  quantity_refrigerated_40ft: 0,
  quantity_special_20ft: 0,
  quantity_special_40ft: 0,
  blocked_for_refund: false,
  status: "pending"
)

# 2. BL with only paid invoices (should allow new invoice)
bl_paid = BillOfLading.create!(
  number: "BLPAID",
  customer: clients.second,
  vessel_name: "PAIDSHIP",
  vessel_voyage: "VY11",
  arrival_date: Date.today - 7,
  freetime: 3,
  quantity_dry_20ft: 1,
  quantity_dry_40ft: 1,
  quantity_refrigerated_20ft: 0,
  quantity_refrigerated_40ft: 0,
  quantity_special_20ft: 0,
  quantity_special_40ft: 0,
  blocked_for_refund: false,
  status: "cleared"
)
Invoice.create!(
  reference: "INVPAID1",
  number: bl_paid.number,
  client_code: bl_paid.customer.client_code,
  client_name: bl_paid.customer.name,
  amount: 500,
  original_amount: 500.0,
  currency: "USD",
  status: "paid",
  invoice_date: Date.today - 2,
  user_id: 1
)

# 3. BL with unpaid invoice (should be skipped)
bl_unpaid = BillOfLading.create!(
  number: "BLUNPAID",
  customer: clients.third,
  vessel_name: "DUECARGO",
  vessel_voyage: "VY22",
  arrival_date: Date.today - 10,
  freetime: 5,
  quantity_dry_20ft: 2,
  quantity_dry_40ft: 2,
  quantity_refrigerated_20ft: 0,
  quantity_refrigerated_40ft: 0,
  quantity_special_20ft: 0,
  quantity_special_40ft: 0,
  blocked_for_refund: false,
  status: "pending"
)
Invoice.create!(
  reference: "INVUNPD",
  number: bl_unpaid.number,
  client_code: bl_unpaid.customer.client_code,
  client_name: bl_unpaid.customer.name,
  amount: 800,
  original_amount: 800.0,
  currency: "USD",
  status: "init",
  invoice_date: Date.today - 1,
  user_id: 1
)

# 4. BL with blocked_for_refund = true
BillOfLading.create!(
  number: "BLBLOCKED",
  customer: clients.fourth,
  vessel_name: "REFUNDLOCK",
  vessel_voyage: "VY33",
  arrival_date: Date.today - 12,
  freetime: 3,
  quantity_dry_20ft: 2,
  quantity_dry_40ft: 1,
  quantity_refrigerated_20ft: 1,
  quantity_refrigerated_40ft: 0,
  quantity_special_20ft: 0,
  quantity_special_40ft: 1,
  blocked_for_refund: true,
  status: "pending"
)

# 5. BL with active refund request
bl_with_refund = BillOfLading.create!(
  number: "BLREFUND",
  customer: clients.fifth,
  vessel_name: "ACTIVEREFUND",
  vessel_voyage: "VY44",
  arrival_date: Date.today - 14,
  freetime: 5,
  quantity_dry_20ft: 2,
  quantity_dry_40ft: 1,
  quantity_refrigerated_20ft: 1,
  quantity_refrigerated_40ft: 1,
  quantity_special_20ft: 0,
  quantity_special_40ft: 0,
  blocked_for_refund: false,
  status: "pending"
)
RefundRequest.create!(
  number: bl_with_refund.number,
  requested_amount: "1000",
  status: "PENDING",
  customer: bl_with_refund.customer,
  bill_of_lading: bl_with_refund,
  id_transitaire: 1,
)

# 6. Valid BL (overdue today, should generate invoice)
BillOfLading.create!(
  number: "BLVALID",
  customer: clients.sample,
  vessel_name: "GENSHIP",
  vessel_voyage: "VY55",
  arrival_date: Date.yesterday,
  freetime: 1,
  quantity_dry_20ft: 2,
  quantity_dry_40ft: 2,
  quantity_refrigerated_20ft: 1,
  quantity_refrigerated_40ft: 0,
  quantity_special_20ft: 0,
  quantity_special_40ft: 0,
  blocked_for_refund: false,
  status: "pending"
)
