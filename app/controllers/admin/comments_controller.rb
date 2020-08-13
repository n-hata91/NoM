class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin_admin!

  def index
    @p = params[:q]
    @q = Comment.ransack(@p)
    @comments = @q.result(distinct: true).all.reverse_order
    @data = Comment.find(params[:data]) if params[:data].present?
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to admin_comments_url
    else
      flash.now[:warning] = '削除に失敗しました'
      redirect_to admin_comments_url
    end
  end
end
