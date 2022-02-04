class Account < ApplicationRecord
    validates :first_name, presence: true, uniqueness: true
    validates :last_name, presence: true, uniqueness: true
    validates :middle_name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: "must be in email format" }
    validates :gender, presence: true
    validates :contact_number, presence: true, length: {minimum: 11, maximum:13}, format: {with: /(\d{4})(\d{3})(\d{4})/, message: 'must be a number'}
    validates :birth_date, presence: true
    validates :home_address, presence: true
    validates :city, presence: true
    validates :zip_code, presence: true, length: {minimum: 4, maximum: 6},
    format: {with: /(\d{2})(\d{2})/, message: 'must be a number'}
    validates :account_number, presence: true
    validates :account_type, presence: true
    has_many :transactions 
    attribute :balance, :integer, default: 0
    validates :balance, numericality: { only_integer: true, greater_than_or_equal_to: 0, message: "must be a number" }
end
