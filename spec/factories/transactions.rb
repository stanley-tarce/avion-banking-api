# frozen_string_literal: true
include GeneratorHelper
FactoryBot.define do
  factory :transaction do
    balance { create_balance }
    transaction_id { transactionid}
    transaction_type { transactiontype }
    amount { rand(1..1000).to_i } 
    account             
  end
end
