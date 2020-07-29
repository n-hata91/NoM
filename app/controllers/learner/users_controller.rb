class Learner::UsersController < ApplicationController
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
      redirect_to learner_user_path(current_learner_user)
    else
      render :edit
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :image, :language, :level, :introduction)
  end
end