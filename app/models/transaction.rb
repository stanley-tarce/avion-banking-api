class Transaction < ApplicationRecord
    belongs_to :account
    validates :balance, presence: true
    validates :transaction_type, presence: true
    validates :amount, presence: true
    before_create :create_transaction_id
    def create_transaction_id
        self.transaction_id = SecureRandom.hex(10)
    end
end
