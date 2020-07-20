require 'rails_helper'

RSpec.describe "Learner::Articles", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/learner/articles/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/learner/articles/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /search" do
    it "returns http success" do
      get "/learner/articles/search"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/learner/articles/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /tipcorn" do
    it "returns http success" do
      get "/learner/articles/tipcorn"
      expect(response).to have_http_status(:success)
    end
  end

end
