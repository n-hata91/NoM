class Admin::UsersController < ApplicationController
  before_action :authenticate_admin_user!
  
  def top
    @users = User.all
    @users_today = today(@users)
    @articles = Article.all
    @users_today = today(@usearticlesrs)
    @comments = Comment.all
    @users_today = today(@comments)
    @tags = Tag.all
    @users_today = today(@tags)
  end

  def index
  end

  def show
  end

  def today(object)
    unless object.blank?
      return object.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    end
  end
end