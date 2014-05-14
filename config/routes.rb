ManipalProject::Application.routes.draw do
  resources :musics
  resources :users
  resources :projects
  resources :sessions, :only => [:new, :create, :destroy]
  resources "contacts", only: [:new, :create]

      root            :to => 'pages#home'
  match '/home',      :to => 'pages#home', via: [:get, :post]
  match '/projects',  :to => 'projects#index', via: [:get, :post]
  match '/skills',    :to => 'pages#skills', via: [:get, :post]
  match '/lifestyle', :to => 'musics#index', via: [:get, :post]
  match '/cv',        :to => 'pages#cv', via: [:get, :post]
  match '/contacts',  :to => 'contacts#new', via: 'get'
  match '/about',     :to => 'pages#about', via: [:get, :post]
  match '/signup',    :to => 'users#new', via: [:get, :post]
  match '/signin',    :to => 'sessions#new', via: [:get, :post]
  match '/signout',   :to => 'sessions#destroy', via: [:delete]
end
