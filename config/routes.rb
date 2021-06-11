Rails.application.routes.draw do
  resources :recruiters
  resources :candidates
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :positions
  resources :skills
  resources :interviews, only: [:index, :show, :create, :update]
  resources :scores

  root 'positions#index'
end
