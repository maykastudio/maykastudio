Rails.application.routes.draw do
  devise_for :users
  
  namespace :manage do
    resources :projects do
      resources :images, only: [:create, :destroy]
    end

    root to: "projects#index"
  end

  resources :projects, only: [:show], path: '' do
    post :select, on: :member
  end

  root to: "home#index"
end
