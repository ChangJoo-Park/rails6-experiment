Rails.application.routes.draw do
  get 'users/:id', to: 'users#show', as: 'user'
  root 'posts#index'
  devise_for :users
  resources :posts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
