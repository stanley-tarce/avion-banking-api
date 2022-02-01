class AccountSerializer < ActiveModel::Serializer
  attributes :id, :account_number, :last_name, :first_name, :middle_name, :gender , :contact_number, :birth_date,:home_address, :city, :zip_code, :email, :balance, :account_type, :transactions
end


    #  "first_name"
    #  "middle_name"
    #  "last_name"
    #  "gender"
    #  "contact_number"
    #  "birth_date"
    #  "home_address"
    #  "city"
    #  "zip_code"
    #  "account_number"
    #  "account_type"
    #  "email"
    #  "balance"