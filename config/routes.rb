Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :fuels, except: :show
  resources :stations do
    resources :prices, only: [:new, :create, :destroy]
    resources :comments, only: [:create, :destroy]
    collection { get :my, :favorites }
    member { get :like, :unlike, :follow }
  end

  root 'page#home'
end
