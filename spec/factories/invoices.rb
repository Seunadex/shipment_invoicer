# == Schema Information
#
# Table name: factures
#
#  id                      :bigint           not null, primary key
#  reference               :string(10)       not null
#  number                  :string(9)        not null
#  client_code             :string(20)       not null
#  client_name             :string(60)       not null
#  amount                  :decimal(12, )    not null
#  original_amount         :decimal(12, 2)
#  currency                :string(6)        default("XOF")
#  status                  :string(10)       default("init"), not null
#  invoice_date            :datetime         not null
#  user_id                 :bigint           not null
#  create_type_utilisateur :string(20)
#  id_utilisateur_update   :bigint
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

FactoryBot.define do
  factory :invoice do
    sequence(:reference) { |n| "INV#{n.to_s.rjust(7, '0')}" }
    sequence(:number) { |n| "INV#{n.to_s.rjust(9, '0')}" }
    association :customer, factory: :customer
    association :bill_of_lading, factory: :bill_of_lading
    client_code { customer.client_code }
    client_name { customer.name }
    amount { Faker::Commerce.price(range: 100.0..10000.0, as_string: true) }
    original_amount { amount }
    currency { "XOF" }
    status { "init" }
    invoice_date { Faker::Date.backward(days: rand(1..30)) }
    user_id { 1 } # Assuming a default user ID for simplicity

    trait :paid do
      status { "paid" }
    end
  end
end
