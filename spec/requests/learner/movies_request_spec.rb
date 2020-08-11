require 'rails_helper'

RSpec.describe "Learner::Movies", type: :request do
  describe "GET /search" do
    it "returns http success" do
      get "/learner/movies/search"
      expect(response).to have_http_status(:success)
    end
  end
end