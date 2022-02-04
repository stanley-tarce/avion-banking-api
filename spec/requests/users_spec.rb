# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  sign_up = {
    user: {
      email: 'test@mail.com',
      password: '12345678',
      password_confirmation: '12345678'
    }
  }
  before do
    post '/signup', params: sign_up
  end

  it 'is expected to create a new user without issues' do
    expect(response).to have_http_status(:success)
  end

  it 'is expected to have a message inside the body' do
    (expect(response.body.include?('User Successfully Created')).to be true)
  end

  it 'is expected to login a user without issues' do
    post '/login', params: sign_up[:user].except(:password_confirmation)
    expect(response).to have_http_status(:success)
  end

  it 'is expected to have a JWT Token inside the repsonse headers' do
    post '/login', params: sign_up[:user].except(:password_confirmation)
    expect(response.headers['Authorization'].present?).to be true
  end

  it 'is expected to run "/show" without issues' do
    post '/login', params: sign_up[:user].except(:password_confirmation)
    authorization = response.headers['Authorization']
    get '/user', headers: { 'Authorization' => authorization }
    expect(response).to have_http_status(:success)
  end
end
