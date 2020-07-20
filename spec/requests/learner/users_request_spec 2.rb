require 'rails_helper'

RSpec.describe "Learner::Users", type: :request do

  describe "GET /top" do
    it "returns http success" do
      get "/learner/users/top"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/learner/users/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/learner/users/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
