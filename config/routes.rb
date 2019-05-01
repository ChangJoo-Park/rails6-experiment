Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users

  resources :posts do
    resources :comments, only: [:create, :update, :destory]
  end

  get 'tags/:tag', to: 'posts#index', as: :tag

  resources :users, only: [:show] do
    patch 'profile', to: 'user_profile#update'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
