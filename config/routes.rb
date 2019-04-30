Rails.application.routes.draw do
  get 'user_profile/edit'
  get 'user_profile/update'
  root 'posts#index'
  devise_for :users
  resources :posts do
    resources :comments, only: [:create, :update, :destory]
  end

  get 'tags/:tag', to: 'posts#index', as: :tag

  get 'users/:id', to: 'users#show', as: 'user'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
