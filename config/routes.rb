Rails.application.routes.draw do

  # アプリケーション
  namespace :learner do
    scope module: :users do
      devise_for :users
    end
    root 'users#top'
    get 'articles/index'
    get 'articles/show'
    get 'articles/search'
    get 'articles/new'
    get 'articles/tipcorn'
  end
  
  namespace :admin do
    scope module: :users do
      devise_for :admins
    end
    get 'tags/index'
    get 'comments/index'
    get 'articles/index'
    get 'articles/show'
    get 'users/index'
    get 'users/show'
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
