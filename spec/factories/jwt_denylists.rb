FactoryBot.define do
  factory :jwt_denylist do
    jti { "MyString" }
    exp { "2022-02-01 01:07:44" }
  end
end
