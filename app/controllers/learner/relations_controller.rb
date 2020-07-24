class Learner::RelationsController < ApplicationController

  def create
    user = User.find(params[:followed_id])
    current_learner_user.follow(user)
    redirect_to request.referer
  end

  def destroy
    user = Relation.find_by(followed_id: params[:id]).followed
    current_learner_user.unfollow(user)
    redirect_to request.referer
  end
  
end
