class Learner::UsersController < ApplicationController
  before_action :authenticate_learner_user!, only: [:welcome, :show ,:edit ,:update]
  before_action :correct_user!, only: [:edit, :update]
  
  def top
  end

  def welcome
    @user = current_learner_user
    @languages = Language.all
  end

  def show
    @user = User.find(params[:id])
    @follows = @user.following
    @followers = @user.followers
    favorite_articles = @user.favorite_articles
    @articles = favorite_articles.page(params[:page])
    @posts_articles = @user.articles
    @posts = @posts_articles.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
    @languages = Language.all
  end

  def update
    @user = current_learner_user
    if @user.update(user_params)
      flash[:notice] = "User info was successfully updated"
      redirect_to learner_articles_path
    else
      render :edit
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :image, :language, :level, :introduction)
  end

  def correct_user!
    user = User.find(params[:id])
    unless current_learner_user.id == user.id
      redirect_to root_path
    end
  end
end