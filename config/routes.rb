Rails.application.routes.draw do
  resources :tasks, except: %i[ show new]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "tasks#index"
end
