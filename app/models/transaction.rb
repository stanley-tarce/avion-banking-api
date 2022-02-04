class Transaction < ApplicationRecord
    before_create :create_transaction_id
    belongs_to :account
    validates :balance, presence: true
    validates :transaction_type, presence: true
    validates :transaction_id, presence: true
    validates :amount, presence: true
    
    def create_transaction_id
        self.transaction_id = SecureRandom.hex(10)
    end
end
