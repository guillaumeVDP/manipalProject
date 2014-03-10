ManipalProject::Application.routes.draw do
  resources :users
  resources :sessions, :only => [:new, :create, :destroy]

      root          :to => 'pages#home'
  match '/home',    :to => 'pages#home', via: [:get, :post]
  match '/contact', :to => 'pages#contact', via: [:get, :post]
  match '/about',   :to => 'pages#about', via: [:get, :post]
  match '/help',    :to => 'pages#help', via: [:get, :post]
  match '/signup',  :to => 'users#new', via: [:get, :post]
  match '/signin',  :to => 'sessions#new', via: [:get, :post]
  match '/signout',  :to => 'sessions#destroy', via: [:get, :post]
end
