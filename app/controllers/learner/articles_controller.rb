class Learner::ArticlesController < ApplicationController
  before_action :authenticate_learner_user!
  before_action :posted_user!, only: [:edit, :update, :destroy]

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
  
  def tipcorn
    @article = Article.new
  end

  def create
    @article = current_learner_user.articles.new(article_params)
    tags = params[:tags].split(",")
    if @article.save
      @article.save_tags(tags)
      flash[:success] = "Articel successfully created"
      @new_comment = Comment.new
      @comments = @article.comments.order(created_at: "desc")
      if @article.movie_id == 1
        redirect_to learner_movie_articles_path
      else
        redirect_to learner_movie_article_path(@article.movie_id, @article)
      end
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
    @movie = Movie.find(@article.movie_id)
    @tags = @article.tags.pluck(:name).join(",")
  end
  
  def update
    @article = Article.find(params[:id])
    tags = params[:tags].split(",")
      if @article.update(article_params)
        @article.save_tags(tags)
        flash[:success] = "Article was successfully updated"
        redirect_to learner_movie_article_path(@article.movie_id, @article)
      else
        flash[:error] = "Something went wrong"
        render 'edit'
      end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash[:success] = 'Article was successfully deleted.'
      redirect_to learner_movie_articles_path
    else
      flash[:error] = 'Something went wrong'
      redirect_to learner_movie_articles_path
    end
  end
  
  
  

  private

  def article_params
    params.require(:article).permit(:user_id, :movie_id, :title, :content, :image, :rate, :difficulty, :length, :practicality, :speed, :accent)
  end

  def posted_user!
    article = Article.find(params[:id])
    unless current_learner_user.id == article.user_id
      redirect_to root_path
    end
  end

end