FactoryBot.define do
  factory :jwt_blacklist do
    jti { "MyString" }
    exp { "2022-02-01 01:07:14" }
  end
end
