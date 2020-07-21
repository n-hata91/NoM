Rails.application.routes.draw do
# アプリケーション
  scope module: :learner do
    root 'users#top'
  end
  namespace :learner do
    scope module: :users do
      devise_for :users,
      controllers: {
        sessions: 'learner/users/sessions',
        registrations: 'learner/users/registrations',
        omniauth_callbacks: 'learner/users/omniauth_callbacks'
      }
      
    end
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
    scope module: :admins do
      devise_for :admins
    end
    root 'users#top'
    resources :users, only: [:index, :show, :update, :destroy]
    resources :articles, only: [:index, :show, :update, :destroy]
    resources :comments, only: [:index, :update, :destroy]
    resources :tags, only: [:index, :update, :destroy]
  end
end