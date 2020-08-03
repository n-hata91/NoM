require 'rails_helper'

RSpec.describe "Learner::Articles", type: :request do
  let(:user) { create(:user)}
  let(:movie) { create(:movie_article) }
  let!(:article) { create(:article, user_id: user.id, movie_id: movie.id) }
  
  describe "GET /index" do
    it "returns http success" do
      get learner_movie_articles_path
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "GET /show" do
    it "returns http success" do
      get learner_movie_article_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get new_learner_movie_article_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" 
      get edit_learner_movie_article_path
      expect(response).to have_http_status(:success)
    end

  describe "GET /tipcorn" do
    it "returns http success" do
      get learner_tipcorn_path
      expect(response).to have_http_status(:success)
    end
  end

end