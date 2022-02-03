# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

include GeneratorHelper

User.create(email: "admin123@gmail.com", password: "Admin123", password_confirmation: "Admin123")

50.times do
    Account.create(account_number: accountnum, account_type: accounttype, last_name: Faker::Name.last_name, first_name: Faker::Name.first_name, middle_name: Faker::Name.middle_name, birth_date: Faker::Date.birthday(min_age: 18, max_age:80), contact_number: contactnumber, email: Faker::Internet.email, home_address: Faker::Address.secondary_address, city: Faker::Address.city, balance: balance, zip_code: zipcode, gender: Faker::Gender.binary_type )
end
