Rails.application.routes.draw do
  
# アプリケーション
  namespace :learner do
    scope module: :users do
      devise_for :users
    end
    root 'users#top'
    resources :users, only: [:show, :edit]
    get 'articles/search' => 'articles#search', as: 'search'
    get 'articles/tipcorn' => 'articles#tipcorn', as: 'tipcorn'
    resources :articles do
      resources :comments, only: [:create, :destroy]
    end
    resources :favorites, only: [:create, :destroy]
    resources :movies, only: [:create]
  end
  
# 管理者
  namespace :admin do
    scope module: :users do
      devise_for :admins
    end
    root 'users#top'
    resources :users, only: [:index, :show, :update, :destroy]
    resources :articles, only: [:index, :show, :update, :destroy]
    resources :comments, only: [:index, :update, :destroy]
    resources :tags, only: [:index, :update, :destroy]
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end