class Admin::ArticlesController < ApplicationController
  before_action :authenticate_admin_admin!
  
  def index
    @p = params[:q]
    @q = Article.ransack(@p)
    @articles = @q.result(distinct: true).page(params[:page]).reverse_order
    @languages = Language.all
  end

  def show
  end
end
