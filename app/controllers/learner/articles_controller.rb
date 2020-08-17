class Learner::ArticlesController < ApplicationController
  before_action :authenticate_learner_user!
  before_action :posted_user!, only: [:edit, :update, :destroy]
  impressionist :actions => [:show]

  def index
    @p = params[:q]
    @q = Article.ransack(@p)
    @articles = @q.result(distinct: true).page(params[:page]).reverse_order
    @languages = Language.all
    @user_ranking = User.follower_ranking(3)
    params[:pv] = { "user_language_eq_all" => "#{current_learner_user.language}" }
    @pv_ranking = Article.ransack(params[:pv]).result(distinct: true).order(impressions_count: :desc).limit(3)
    @tag_ranking = Tag.tag_ranking(10)
    if params[:welcome]
      @first_visitor = "true"
    end
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
    @article = Article.new(movie_id: 1)
  end

  def create
    @article = current_learner_user.articles.new(article_params)
    @article.score = Analyze.get_data(params["article"]["content"])
    unless params[:tags].nil?
      tags = params[:tags].split(",")
    end
    if @article.save
      @article.save_tags(tags)
      @new_comment = Comment.new
      @comments = @article.comments.order(created_at: "desc")
      if @article.movie_id == 1
        redirect_to learner_movie_articles_path
      else
        redirect_to learner_movie_article_path(@article.movie_id, @article)
      end
    else
      flash.now[:warning] = "入力をご確認ください"
      if @article.movie_id == 1
        render :tipcorn
      else
        @movie = Movie.find(@article.movie_id)
        render :new
      end
    end
  end

  def edit
    @article = Article.find(params[:id])
    @movie = Movie.find(@article.movie_id)
    @tags = @article.tags.pluck(:name).join(",")
  end

  def update
    @article = Article.find(params[:id])
    @article.score = Analyze.get_data(@article.content)
    unless params[:tags].nil?
      tags = params[:tags].split(",")
    end
    if @article.update(article_params)
      @article.save_tags(tags)
      redirect_to learner_movie_article_path(@article.movie_id, @article)
    else
      @article = Article.find(params[:id])
      @movie = Movie.find(@article.movie_id)
      @tags = @article.tags.pluck(:name).join(",")
      flash.now[:warning] = '入力をご確認ください'
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      redirect_to learner_movie_articles_path
    else
      flash.now[:warning] = '削除に失敗しました'
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
