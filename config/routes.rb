Rails.application.routes.draw do
  get 'notifications/new'
  get 'notifications/create'
  get 'notifications/completed'
  devise_for :users
  get 'relationships/create'
  get 'relationships/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource  :favorites, only: [:create, :destroy]
    resources  :book_comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:index,:show,:edit,:update] do
     get '/search_count/:id', to: 'users#search_count', as: 'search_count'
  end
  resources :relationships, only: [:create, :destroy]
  resources :searches, only: [:index] do
   
  end
  resources :groups do
     resources :users do
      post 'join', to: 'group_users#join'
      delete 'leave', to: 'group_users#destroy'
    end
  end
  resources :groups, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :chats, only: [:index, :create]
  resources :view_counts, only: [:create]
  
  resources :notifications, only: [:new, :create] do
    collection do
      get :completed
    end
  end
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
