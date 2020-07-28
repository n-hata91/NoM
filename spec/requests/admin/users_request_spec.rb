require 'rails_helper'

RSpec.describe "Admin::Users", type: :request do

  describe "GET /top" do
    it "returns http success" do
      get "/admin/users/top"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/admin/users/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/admin/users/show"
      expect(response).to have_http_status(:success)
    end
  end

end
