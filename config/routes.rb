Rails.application.routes.draw do
  devise_for :users

  resources :todos do
    member do
      patch :toggle_complete
    end
  end

  root "todos#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
