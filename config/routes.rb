Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: { registrations: 'user/registrations' }

  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'

  unauthenticated :user do
    root to: 'pages#index'
  end

  authenticated :user do
    root 'tasks#week'
  end

  resources :tasks do
    member do
      get 'complete'
      get 'archive'
    end
  end

  resources :task_categories

  match '/form-input', to: 'tasks#keep_form_input', via: %i[patch post]
  get '/week', to: 'tasks#week'
  get '/day', to: 'tasks#day'
  get '/about', to: 'pages#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
