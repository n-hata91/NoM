class Admin::UsersController < ApplicationController
  before_action :authenticate_admin_admin!

  def top
    @users = User.all
    @users_today = today(@users)
    @articles = Article.all
    @movie_articles = Tag.article_count('movie')
    @tipcorn_articles = Tag.article_count('tipcorn')
    @users_today = today(@usearticlesrs)
    @comments = Comment.all
    @users_today = today(@comments)
    @tags = Tag.all
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
    # csvエクスポート
    respond_to do |format|
      format.html
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
