class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :transaction_type, :transaction_id, :balance, :amount
end
