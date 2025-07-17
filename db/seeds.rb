# Seed data for clients
clients = 5.times.map do |i|
  Customer.create!(
    name: Faker::Company.name,
    status: %w[active inactive].sample,
    client_code: "C#{1000 + i}",
    group_name: Faker::Company.suffix,
    deposit_required: [true, false].sample,
    freetime_refrigerated: rand(5..15),
    freetime_dry: rand(5..10),
    priority: [true, false].sample,
    sales_rep_id: nil,
    finance_rep_id: nil,
    cservice_rep_id: nil,
    validity_date: Faker::Date.forward(days: 90),
    operator: Faker::Name.first_name
  )
end

# Seed data for BLs
10.times do |i|
  client = clients.sample
  BillOfLading.create!(
    number: "BL#{1000 + i}",
    customer_id: client.id,
    vessel_name: Faker::Lorem.word.upcase,
    vessel_voyage: "VY#{rand(10..99)}",
    arrival_date: Faker::Date.backward(days: rand(5..20)),
    freetime: rand(5..10),
    quantity_dry_20ft: rand(0..5),
    quantity_dry_40ft: rand(0..5),
    quantity_refrigerated_20ft: rand(0..3),
    quantity_refrigerated_40ft: rand(0..3),
    quantity_special_20ft: rand(0..2),
    quantity_special_40ft: rand(0..2),
    status: %w[pending cleared].sample
  )
end

# Seed data for Invoices
5.times do |i|
  bl = BillOfLading.order("RAND()").first
  client = Customer.find(bl.customer_id)
  Invoice.create!(
    reference: "INV#{1000 + i}",
    number: bl.number,
    client_code: client.client_code,
    client_name: client.name,
    amount: rand(1000..5000),
    original_amount: rand(1000.0..5000.0).round(2),
    currency: "USD",
    status: %w[init paid].sample,
    invoice_date: Faker::Date.backward(days: rand(0..5)),
    user_id: 1
  )
end
