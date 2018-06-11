Rails.application.routes.draw do
  #devise_for :users
  devise_for :users, controllers: { registrations: "user/registrations" }
  
  unauthenticated :user do
    root to: "pages#index"
  end

  authenticated :user do
    root "tasks#week"
	end

  resources :tasks do
    member do
      get 'complete'
    end
  end

  resources :task_categories

  post '/form-input', to: 'tasks#keep_form_input'
  get '/week', to: 'tasks#week'
  get '/day', to: 'tasks#day'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
