Rails.application.routes.draw do
  root to: 'site#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :users
    resources :chores
    resource :chore_calendar, only: [:show], :controller => 'chore_calendar'
  end
end
