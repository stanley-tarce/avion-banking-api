# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is expected to create a new user without issues' do
    user = FactoryBot.create(:user)
    expect(user).to be_valid
  end

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to allow_value(Faker::Internet.email).for(:email) }
end
