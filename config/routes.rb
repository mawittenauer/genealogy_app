Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  get 'dashboard', to: 'pages#dashboard'
  resources :family_trees, only: [:create, :show, :edit, :update, :destroy] do
    resources :people, only: [:show, :edit, :update, :destroy, :new] do
      get 'tree', to: 'people#tree'
      get 'new_spouse', to: 'people#new_spouse'
    end
    resources :relationships, only: [:new]
    post 'people', to: 'family_trees#create_person', as: 'create_person'
  end
  resources :relationships, only: [:create, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
