# == Schema Information
#
# Table name: bls
#
#  id                         :bigint           not null, primary key
#  id_upload                  :bigint
#  upload_date                :datetime
#  number                     :string(9)        not null
#  customer_id                :bigint
#  consignee_code             :string(20)
#  consignee_name             :string(60)
#  notified_code              :string(20)
#  notified_name              :string(60)
#  vessel_name                :string(30)
#  vessel_voyage              :string(10)
#  arrival_date               :datetime
#  freetime                   :integer
#  quantity_dry_20ft          :integer
#  quantity_dry_40ft          :integer
#  quantity_refrigerated_20ft :integer
#  quantity_refrigerated_40ft :integer
#  quantity_special_20ft      :integer
#  quantity_special_40ft      :integer
#  reef                       :string(1)        default("")
#  unloading_type             :string(30)
#  validity_date              :datetime
#  status                     :string(30)
#  exempt                     :boolean          default(FALSE), not null
#  blocked_for_refund         :boolean          default(FALSE), not null
#  reference                  :string(60)
#  comment                    :text(65535)
#  valid_flag                 :boolean
#  released_status            :string(20)
#  released_notes             :text(65535)
#  operator                   :string(20)
#  atp                        :string(30)
#  consignee_caution          :boolean          default(FALSE), not null
#  service_contract           :string(200)
#  bank_account               :string(30)
#  bank_name                  :string(30)
#  emails                     :string(60)
#  telephone                  :string(20)
#  receipt_location           :string(60)
#  delivery_location          :string(60)
#  loading_port               :string(60)
#  discharge_port             :string(60)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
FactoryBot.define do
  factory :bill_of_lading do
    # bol_number { "BOL#{Faker::Number.unique.number(digits: 8)}" }
    # shipper_name { Faker::Company.name }
    # consignee_name { Faker::Company.name }
    # origin_port { Faker::Address.city }
    # destination_port { Faker::Address.city }
    # vessel_name { Faker::Lorem.word }
    # voyage_number { Faker::Number.number(digits: 4) }
    # cargo_details { Faker::Commerce.product_name }
    # gross_weight { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    # created_at { Time.current }
    # updated_at { Time.current }
  end
end
