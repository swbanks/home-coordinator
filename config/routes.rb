Rails.application.routes.draw do
  root to: 'site#index'
  get '/parent', to: 'site#index'
  get '/parent_checker', to: 'site#index'
  get '/chores', to: 'site#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :users
    resources :chores
    resource :chore_calendar, only: [:show, :update], :controller => 'chore_calendar'
  end
end
