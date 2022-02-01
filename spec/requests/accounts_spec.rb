require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/accounts/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/accounts/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/accounts/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      get "/accounts/delete"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/accounts/create"
      expect(response).to have_http_status(:success)
    end
  end

end
