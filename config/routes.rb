Rails.application.routes.draw do
  resources :recruiters
  resources :candidates
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :positions
  resources :skills
  resources :interviews, only: [:index, :show, :create, :update]
  resources :scores
  resources :users, only: [:new, :create, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]

  root 'positions#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'
end
