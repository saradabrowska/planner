Rails.application.routes.draw do
  devise_for :users
 
  unauthenticated :user do
    root to: "pages#index"
  end

  authenticated :user do
    root "tasks#day"
	end

  resources :tasks do
    member do
      get 'complete'
    end
  end

  get '/week', to: 'tasks#week'
  get '/day', to: 'tasks#day'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
