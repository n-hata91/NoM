class Learner::FavoritesController < ApplicationController
  before_action :authenticate_learner_user!

  def create
    @article = Article.find(params[:format])
    favorite = current_learner_user.favorites.new(article_id: @article.id)
    favorite.save
  end
  
  def destroy
    @article = Article.find(params[:id])
    favorite = current_learner_user.favorites.find_by(article_id: @article.id)
    favorite.destroy
  end

end
