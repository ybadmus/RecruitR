Rails.application.routes.draw do
  resources :recruiters
  resources :candidates
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :positions#, only: [:index, :new, :show, :edit, :create]
  resources :skills#, only: [:index, :new, :show, :edit, :create]

  root 'positions#index'
end
