# == Schema Information
#
# Table name: remboursements
#
#  id                    :bigint           not null, primary key
#  number                :string(9)        not null
#  requested_amount      :string(15)
#  refund_amount         :string(15)
#  deduction             :string(15)
#  status                :string(10)       default("pending")
#  id_transitaire        :bigint           not null
#  id_transitaire_maison :bigint
#  transitaire_notifie   :boolean
#  maison_notifie        :boolean
#  banque_notifie        :boolean
#  date_demande          :datetime
#  date_refund_traite    :datetime
#  type_paiement         :string(10)
#  pret                  :string(10)
#  soumis                :string(10)
#  consignee_code        :string(14)
#  refund_party_name     :string(200)
#  beneficiaire          :string(20)
#  deposit_amount        :string(15)
#  refund_reason         :string(200)
#  remarks               :string(250)
#  co_code               :string(20)
#  zm_doc_no             :text(65535)
#  gl_posting_doc        :string(15)
#  clearing_doc          :string(15)
#  email_address         :string(60)
#  type_depotage         :string(40)
#  accord_client         :boolean
#  comment               :text(65535)
#  reference             :string(30)
#  date_agent_notified   :datetime
#  date_agency_notified  :datetime
#  date_client_notified  :datetime
#  date_banque_notified  :datetime
#  email_agency          :string(60)
#  email_client          :string(60)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#


FactoryBot.define do
  factory :refund_request do
    sequence(:number) { |n| "RF#{n.to_s.rjust(9, '0')}" }
    requested_amount { Faker::Commerce.price(range: 100.0..10000.0, as_string: true) }
    refund_amount { requested_amount }
    deduction { "0.00" }
    status { "pending" }
    association :transitaire, factory: :customer
    transitaire_notifie { false }
    maison_notifie { false }
    banque_notifie { false }
    date_demande { Faker::Date.backward(days: rand(1..30)) }
    type_paiement { "bank_transfer" }
    pret { "no" }
    soumis { "no" }
    consignee_code { Faker::Alphanumeric.alphanumeric(number: 14).upcase }
    refund_party_name { Faker::Company.name }
    beneficiaire { Faker::Name.name }
    deposit_amount { Faker::Commerce.price(range: 50.0..5000.0, as_string: true) }
    refund_reason { Faker::Lorem.sentence(word_count: 10) }
    remarks { Faker::Lorem.sentence(word_count: 15) }
    co_code { Faker::Alphanumeric.alphanumeric(number: 20).upcase }
    zm_doc_no { nil }
    gl_posting_doc { nil }
    clearing_doc { nil }
    email_address { Faker::Internet.email }
    type_depotage { "standard" }
    accord_client { [ true, false ].sample }
    comment { Faker::Lorem.paragraph(sentence_count: 2) }
    reference { Faker::Alphanumeric.alphanumeric(number: 30).upcase }
  end
end
