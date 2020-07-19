Rails.application.routes.draw do

  # アプリケーション
  scope module: :users do
    devise_for :users
  end
  
  devise_for :admins


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
