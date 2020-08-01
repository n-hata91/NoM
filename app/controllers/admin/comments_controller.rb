class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin_admin!
  
  def index
    @p = params[:q]
    @q = Comment.ransack(@p)
    @comments = @q.result(distinct: true).page(params[:page]).reverse_order
  end
end
