# frozen_string_literal: true

require 'rails_helper'
include GeneratorHelper
RSpec.describe Account, type: :model do
  it 'is expected to create a new account without issues' do
    account = FactoryBot.create(:account)
    expect(account).to be_valid
  end

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:middle_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:birth_date) }
  it { is_expected.to validate_presence_of(:contact_number) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:home_address) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:zip_code) }
  it { is_expected.to validate_presence_of(:account_number) }
  it { is_expected.to validate_presence_of(:account_type) }
  it { is_expected.to validate_presence_of(:gender) }
  it { is_expected.to allow_value(contactnumber).for(:contact_number) }
  it { is_expected.to allow_value(create_balance).for(:balance) }
  it { is_expected.to allow_value(Faker::Internet.email).for(:email) }
  it { is_expected.to validate_length_of(:contact_number).is_at_least(11).is_at_most(13) }
  it { is_expected.to validate_length_of(:zip_code).is_at_least(4).is_at_most(6) }
end
