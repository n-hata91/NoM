class Learner::UsersController < ApplicationController
  def top
  end

  def welcome
  end

  def show
    @follows = User.all[1..5] #開発用
    @followers = User.all[6..10] #開発用
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
end
