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
    resources :followers,  only: [:index]
    resources :followings, only: [:index]
  end

  # post "relationships", to: "relationships#create"
  # delete "relationships/:id", to: "relationships#destroy"
  resources :relationships, only: %i[create destroy]

  # Static Pages
  get "about", to: "static_pages#about"
  get "sponsors", to: "static_pages#sponsors"
  get "privacy", to: "static_pages#privacy"
  get "code-of-conduct", to: "static_pages#code_of_conduct"
  get "terms", to: "static_pages#terms"
  get "contact", to: "static_pages#contact"
  get "faq", to: "static_pages#faq"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
