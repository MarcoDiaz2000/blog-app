Rails.application.routes.draw do
  devise_for :users, skip: [:sessions]
  as :user do
    get 'login' => 'devise/sessions#new', as: :new_user_session
    post 'login' => 'devise/sessions#create', as: :user_session
    get 'logout' => 'devise/sessions#destroy', as: :destroy_user_session
  end

  root 'users#index'
  resources :users, only: [:index, :show, :destroy] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:create, :destroy]
      resources :likes, only: [:create, :destroy]
    end
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :destroy] do
        resources :posts, only: [:index, :show, :new, :create, :destroy] do
          resources :comments, only: [:index, :create, :destroy]
          resources :likes, only: [:index, :create, :destroy]
        end
      end
    end
  end


end

