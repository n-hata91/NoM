class Admin::UsersController < ApplicationController
  before_action :authenticate_admin_admin!
  
  def top
    @users = User.all
    @users_today = today(@users)
    @articles = Article.all
    @users_today = today(@usearticlesrs)
    @comments = Comment.all
    @users_today = today(@comments)
    @tags = Tag.all
    @users_today = today(@tags)
    @ranking_users = User.ranking(3)
  end

  def index
    @p = params[:q]
    @q = User.ransack(@p)
    @users = @q.result(distinct: true).page(params[:page]).reverse_order
    @languages = Language.all
    @data = User.find(params[:data]) if params[:data].present?
  end

  def show
  end

  def today(object)
    unless object.blank?
      return object.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    end
  end
end