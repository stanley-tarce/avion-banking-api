include GeneratorHelper

FactoryBot.define do
  factory :account do
    first_name { Faker::Name.first_name }
    middle_name { Faker::Name.middle_name }
    last_name { Faker::Name.last_name }
    gender { Faker::Gender.binary_type }
    contact_number { contactnumber }
    birth_date { Faker::Date.birth }
    home_address { Faker::Address.secondary_address }
    city { Faker::Address.city }
    zip_code { zipcode }
    account_number { accountnum }
    account_type { accounttype }
    email { Faker::Internet.email }
    balance { create_balance }
  end
end
