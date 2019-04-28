Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users
  resources :posts do
    resources :comments, only: [:create, :update, :destory]
  end
  get 'users/:id', to: 'users#show', as: 'user'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
