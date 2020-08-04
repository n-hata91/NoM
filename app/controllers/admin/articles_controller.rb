class Admin::ArticlesController < ApplicationController
  before_action :authenticate_admin_admin!
  
  def index
    @p = params[:q]
    @q = Article.ransack(@p)
    @articles = @q.result(distinct: true).all.reverse_order
    @languages = Language.all
    if params[:data]
      @data = Article.find(params[:data])
    end
  end

  def show
  end
end
