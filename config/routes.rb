# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :prompts, only: [:index]

  resources :daily_prompts, only: [:index] do
    collection do
      get :today
    end
  end

  devise_scope :user do
    get '/me', to: 'sessions#current'
  end

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  }, controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }
end
