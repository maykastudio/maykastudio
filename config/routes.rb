Rails.application.routes.draw do
  devise_for :users
  
  namespace :manage do
    resources :projects do
      resources :images, only: [:create, :destroy]
    end

    root to: "projects#index"
  end

  root to: "home#index"
end
