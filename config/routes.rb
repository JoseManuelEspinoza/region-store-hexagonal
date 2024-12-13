Rails.application.routes.draw do

  namespace :authentication, path: '', as:'' do
    resources :users, only: [:new, :create],path: '/register', path_names: {new: '/'}
    resources :sessions, only: [:new, :create, :destroy],path: '/login', path_names: {new: '/'}
  end
  resources :carritos, only: [:index, :create, :destroy], param: :producto_id
  resources :regions, except: :show
  resources :cargos, only: [:index, :new, :create]

  # Ruta raíz
  root to: 'productos#index'

  resources :productos


end
