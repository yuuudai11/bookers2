Rails.application.routes.draw do
  devise_for :users
  get 'home/about' => 'homes#about', as: 'about'
  root to: "homes#top"

  resources :users, only: [:show, :edit, :index, :update]
  resources :books, only: [:new, :index, :create, :show, :edit, :update, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
