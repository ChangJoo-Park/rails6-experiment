# frozen_string_literal: true

Rails.application.routes.draw do
  root "posts#index"
  devise_for :users

  resources :posts do
    resources :comments, only: %i[create update destory]
    resource :favorite, only: %i[create destroy]
    member do
      put :publish
      patch :publish
    end
    member do
      put :unpublish
      patch :unpublish
    end

  end

  get "tags/:tag", to: "posts#index", as: :tag

  resources :users, only: [:show] do
    patch "profile", to: "user_profile#update"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
