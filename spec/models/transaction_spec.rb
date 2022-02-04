# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it 'is expected to create a new transaction without issues' do
    transaction = FactoryBot.create(:transaction)
    expect(transaction).to be_valid
  end

  it { is_expected.to validate_presence_of(:balance) }
  it { is_expected.to validate_presence_of(:transaction_type) }
  it { is_expected.to validate_presence_of(:transaction_id) }
  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to belong_to(:account) }
end
