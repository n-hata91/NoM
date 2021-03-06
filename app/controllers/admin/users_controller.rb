class Admin::UsersController < ApplicationController
  before_action :authenticate_admin_admin!

  def top
    @users = User.all
    @users_today = today(@users)
    @articles = Article.all
    @negative_articles = Article.where(score: -1..-0.5)
    @movie_articles = Tag.article_count('movie')
    @tipcorn_articles = Tag.article_count('tipcorn')
    @users_today = today(@usearticlesrs)
    @comments = Comment.all
    @negative_comments = Comment.where(score: -1..-0.5)
    @users_today = today(@comments)
    @tags = Tag.all
    @negative_tags = Tag.where(score: -1..-0.5)
    @users_today = today(@tags)
    @user_ranking = User.post_ranking(3)
    @pv_ranking = Article.pv_ranking(3)
  end

  def index
    @p = params[:q]
    @q = User.ransack(@p)
    @users = @q.result(distinct: true).all.reverse_order
    @languages = Language.all
    @data = User.find(params[:data]) if params[:data].present?
    respond_to do |format|
      format.html
      format.js
      format.csv do
        send_data render_to_string,
                  filename: "利用者.csv"
      end
    end
  end

  def show
  end

  def today(object)
    if object.present?
      object.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    end
  end
end
