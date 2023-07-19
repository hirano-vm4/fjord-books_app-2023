Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  resources :books
  resources :users, only:[:index, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'books#index'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  # Defines the root path route ("/")
  # root "articles#index"
end
