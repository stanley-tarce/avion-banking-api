# frozen_string_literal: true

require 'rails_helper'
include GeneratorHelper
RSpec.describe 'Accounts', type: :request do
  account_params = {
    account: {
      account_number: accountnum,
      account_type: accounttype,
      last_name: Faker::Name.last_name,
      first_name: Faker::Name.first_name,
      middle_name: Faker::Name.middle_name,
      birth_date: Faker::Date.birthday(min_age: 18, max_age: 80),
      contact_number: contactnumber,
      email: Faker::Internet.email,
      home_address: Faker::Address.secondary_address,
      city: Faker::Address.city,
      balance: create_balance,
      zip_code: zipcode,
      gender: Faker::Gender.binary_type
    }
  }
  before do
    sign_up = {
      user: {
        email: 'test@mail.com',
        password: '12345678',
        password_confirmation: '12345678'
      }
    }
    post '/signup', params: sign_up
    post '/login', params: sign_up[:user].except(:password_confirmation)
  end

  it 'is expected to run "/accounts" without issues ' do
    @authorization = response.headers['Authorization']
    get '/accounts', headers: { Authorization: @authorization }
    expect(response).to have_http_status(:success)
  end

  it 'is expected to run "/accounts/:id" without issues' do
    @authorization = response.headers['Authorization']
    FactoryBot.create(:account)
    get "/accounts/#{Account.first.account_number}", headers: { Authorization: @authorization }
    expect(response).to have_http_status(:success)
  end

  it 'is expected to create a new account without issues' do
    @authorization = response.headers['Authorization']
    post '/accounts', headers: { Authorization: @authorization }, params: account_params
    expect(response).to have_http_status(:ok)
  end

  it 'is expected to update an account without issues' do
    @authorization = response.headers['Authorization']
    FactoryBot.create(:account)
    patch "/accounts/#{Account.first.account_number}", headers: { Authorization: @authorization },
                                                       params: account_params
    expect(response).to have_http_status(:ok)
  end

  it 'is expected to delete an account without issues' do
    @authorization = response.headers['Authorization']
    FactoryBot.create(:account)
    delete "/accounts/#{Account.first.account_number}", headers: { Authorization: @authorization }
    expect(response).to have_http_status(:ok)
  end

  it 'is expected to run "/accounts/:id/transfer" without issues' do
    @authorization = response.headers['Authorization']
    FactoryBot.create_list(:account, 2)
    patch "/accounts/#{Account.first.account_number}/transfer?account_number=#{Account.last.account_number}",
          headers: { Authorization: @authorization }, params: { amount: 200 }
    expect(response).to have_http_status(:success)
  end

  it 'is expected to have a transaction model after running the request' do
    @authorization = response.headers['Authorization']
    FactoryBot.create_list(:account, 2)
    patch "/accounts/#{Account.first.account_number}/transfer?account_number=#{Account.last.account_number}",
          headers: { Authorization: @authorization }, params: { amount: 200 }
    expect(Transaction.first.account).to eq(Account.first)
  end

  it 'is expected to run an error if account number can not be found' do
    @authorization = response.headers['Authorization']
    FactoryBot.create_list(:account, 2)
    patch "/accounts/#{Account.first.account_number}/transfer?account_number=123",
          headers: { Authorization: @authorization }, params: { amount: 200 }
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'is expected to run an error if amount is not a number' do
    @authorization = response.headers['Authorization']
    FactoryBot.create_list(:account, 2)
    patch "/accounts/#{Account.first.account_number}/transfer?account_number=#{Account.last.account_number}",
          headers: { Authorization: @authorization }, params: { amount: 'a' }
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'is expected to run an error if amount is insufficient' do
    @authorization = response.headers['Authorization']
    FactoryBot.create_list(:account, 2)
    patch "/accounts/123/transfer?account_number=#{Account.last.account_number}",
          headers: { Authorization: @authorization }, params: { amount: Account.first.balance + 1 }
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'is expected to run an error if account number cannot be found (current user)' do
    @authorization = response.headers['Authorization']
    FactoryBot.create_list(:account, 2)
    patch "/accounts/123/transfer?account_number=#{Account.last.account_number}",
          headers: { Authorization: @authorization }, params: { amount: 'a' }
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'is expected to run deposit without issues' do
    @authorization = response.headers['Authorization']
    FactoryBot.create(:account)
    patch "/accounts/#{Account.first.account_number}/deposit", headers: { Authorization: @authorization },
                                                               params: { amount: 200 }
    expect(response).to have_http_status(:success)
  end

  it 'is expected to have a transaction model after running the request' do
    @authorization = response.headers['Authorization']
    FactoryBot.create(:account)
    patch "/accounts/#{Account.first.account_number}/deposit", headers: { Authorization: @authorization },
                                                               params: { amount: 200 }
    expect(Transaction.first.account).to eq(Account.first)
  end

  it 'is expected to have an error when depositing with an invalid amount' do
    @authorization = response.headers['Authorization']
    FactoryBot.create(:account)
    patch "/accounts/#{Account.first.account_number}/deposit", headers: { Authorization: @authorization },
                                                               params: { amount: 'asd' }
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'is expected to run withdraw without issues' do
    @authorization = response.headers['Authorization']
    FactoryBot.create(:account)
    patch "/accounts/#{Account.first.account_number}/withdraw", headers: { Authorization: @authorization },
                                                                params: { amount: 200 }
    expect(response).to have_http_status(:success)
  end

  it 'is expected to have a transaction model after running the request' do
    @authorization = response.headers['Authorization']
    FactoryBot.create(:account)
    patch "/accounts/#{Account.first.account_number}/withdraw", headers: { Authorization: @authorization },
                                                                params: { amount: 200 }
    expect(Transaction.first.account).to eq(Account.first)
  end

  it 'is expected to have an error when withdrawing with an invalid amount' do
    @authorization = response.headers['Authorization']
    FactoryBot.create(:account)
    patch "/accounts/#{Account.first.account_number}/withdraw", headers: { Authorization: @authorization },
                                                                params: { amount: 'asd' }
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'is expected to run an error if amount is insufficient' do
    @authorization = response.headers['Authorization']
    FactoryBot.create(:account)
    patch "/accounts/#{Account.first.account_number}/withdraw", headers: { Authorization: @authorization },
                                                                params: { amount: Account.first.balance + 1 }
    expect(response).to have_http_status(:unprocessable_entity)
  end
end
