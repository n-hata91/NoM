class Learner::ArticlesController < ApplicationController
  def index
    @articles = Article.page(params[:page]).reverse_order
  end

  def show
    @article = Article.find(params[:id])
    @new_comment = Comment.new
    @comments = @article.comments.order(created_at: "desc")
  end

  def new
    @movie = Movie.find(params[:movie_id])
    @article = Article.new
  end

  def create
    @article = current_learner_user.articles.new(article_params)
    if @article.save
      flash[:success] = "Articel successfully created"
      @new_comment = Comment.new
      @comments = @article.comments.order(created_at: "desc")
      redirect_to learner_movie_article_path(@article.movie_id,@article)
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