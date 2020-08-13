class Admin::ArticlesController < ApplicationController
  before_action :authenticate_admin_admin!

  def index
    @p = params[:q]
    @q = Article.ransack(@p)
    @articles = @q.result(distinct: true).all.reverse_order
    @languages = Language.all
    @data = Article.find(params[:data]) if params[:data].present?
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      redirect_to admin_articles_url
    else
      flash.now[:warning] = '入力をご確認ください'
      redirect_to admin_articles_url
    end
  end
end
