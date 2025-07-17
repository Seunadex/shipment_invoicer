# == Schema Information
#
# Table name: clients
#
#  id                    :bigint           not null, primary key
#  name                  :string(60)       not null
#  status                :string(20)
#  client_code           :string(20)
#  group_name            :string(150)      not null
#  deposit_required      :boolean          not null
#  freetime_refrigerated :integer
#  freetime_dry          :integer
#  priority              :boolean
#  sales_rep_id          :bigint
#  finance_rep_id        :bigint
#  cservice_rep_id       :bigint
#  validity_date         :datetime
#  operator              :string(20)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#


FactoryBot.define do
  factory :customer do
    sequence(:name) { |n| "Customer #{n}" }
    status { "active" }
    client_code { Faker::Alphanumeric.alphanumeric(number: 10).upcase }
    group_name { "Group #{Faker::Lorem.word}" }
    deposit_required { [ true, false ].sample }
    freetime_refrigerated { rand(5..15) }
    freetime_dry { rand(5..15) }
    priority { [ true, false ].sample }
    validity_date { Faker::Date.forward(days: 30) }
    operator { Faker::Name.name[0...20] }

    trait :inactive do
      status { "inactive" }
    end

    trait :with_customers do
      after(:create) do |customer|
        create_list(:customer, 3, group_name: customer.group_name)
      end
    end
  end
end
