class Admin::TagsController < ApplicationController
  before_action :authenticate_admin_admin!
  
  def index
    @p = params[:q]
    @q = Tag.ransack(@p)
    @tags = @q.result(distinct: true).page(params[:page]).reverse_order
  end
end
