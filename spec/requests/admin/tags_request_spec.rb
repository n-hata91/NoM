require 'rails_helper'

RSpec.describe "Admin::Tags", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/admin/tags/index"
      expect(response).to have_http_status(:success)
    end
  end

end
