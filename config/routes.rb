Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :fuels, except: :show
  resources :stations do
    resources :prices, except: [:index, :show]
    resources :comments, only: [:create, :delete]
    collection { get :my, :favorites }
    member { get :like, :unlike, :follow }
  end

  root 'page#home'
end
