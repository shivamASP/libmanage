Rails.application.routes.draw do
  get 'issuebook/viewissuedbooks'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :books
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
    get '/users/password', to: 'devise/passwords#new'
  end 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  get 'home/about'
  put '/issuebook/:id/', to: 'issuebook#issue', as: 'issuebook'
  delete '/issuebook/:id/', to: "issuebook#return"
  get '/issuebook/:id/', to: 'issuebook#viewissuedbooks'
end
