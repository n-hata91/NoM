class Learner::ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @movie = Movie.find(params[:format])
    @article = Article.new
  end

  def create
    @article = current_learner_user.articles.new(article_params)
    if @article.save
      flash[:success] = "Articel successfully created"
      redirect_to root_path
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def tipcorn
  end

  private
  def article_params
    params.require(:article).permit(:user_id, :movie_id, :title, :content, :rate, :difficulty, :length, :practicality, :speed, :accent)
  end
end