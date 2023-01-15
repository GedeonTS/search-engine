Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "items#index"
   get 'item/:q', to: 'items#show'
   resources :items, only: %i[index create new]
   resources :analytics, only: %i[create destroy new]
end
