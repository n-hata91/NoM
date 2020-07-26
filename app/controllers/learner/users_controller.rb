class Learner::UsersController < ApplicationController
  def top
  end

  def welcome
  end

  def show
    @user = User.find(params[:id])
    @follows = @user.following
    @followers = @user.followers
  end

  def edit
    @user = User.find(params[:id])
  end
end
