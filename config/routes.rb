Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users
  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource  :favorites, only: [:create, :destroy]
    resource  :book_comments, only: [:create]
  end
  
  resources :users, only: [:index,:show,:edit,:update]
  resources :relationships, only: [:create, :destroy]
  resources :searches, only: [:index]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
