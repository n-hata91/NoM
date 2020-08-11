class Admin::TagsController < ApplicationController
  before_action :authenticate_admin_admin!

  def index
    @p = params[:q]
    @q = Tag.ransack(@p)
    if params[:q]
      @tags = @q.result(distinct: true).all
    else
      @tags = Tag.find(ArticleTag.group(:tag_id).order('count(tag_id) desc').all.pluck(:tag_id))
    end
    @data = Tag.find(params[:data]) if params[:data].present?
  end

  def destroy
    tag = Tag.find(params[:id])
    if tag.destroy
      redirect_to admin_tags_url
    else
      flash.now[:warning] = '削除に失敗しました'
      redirect_to admin_tags_url
    end
  end
end
