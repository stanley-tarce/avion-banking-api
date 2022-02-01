FactoryBot.define do
  factory :account do
    first_name { "MyString" }
    middle_name { "MyString" }
    last_name { "MyString" }
    gender { "MyString" }
    contact_number { "MyString" }
    birth_date { "MyString" }
    home_address { "MyString" }
    city { "MyString" }
    zip_code { "MyString" }
    account_number { "MyString" }
    account_type { "MyString" }
    email { "MyString" }
    balance { 1 }
  end
end
