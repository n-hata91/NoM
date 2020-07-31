class Admin::ArticlesController < ApplicationController
  before_action :authenticate_admin_user!
  
  def index
  end

  def show
  end
end
