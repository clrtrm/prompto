# frozen_string_literal: true

Rails.application.routes.draw do # rubocop:disable Metrics/BlockLength
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :prompts, only: [:index]

  resources :daily_prompts, only: [:index] do
    collection do
      get :today
    end
  end

  resources :daily_prompts, only: %i[show update], param: :date, constraints: { date: DailyPrompt::DATE_FORMAT } do
    resources :replies, only: %i[create]
    member do
      get :reply
    end
  end

  resources :replies, only: %i[update]

  resources :reveals, only: [:show], param: :date, constraints: { date: DailyPrompt::DATE_FORMAT }

  devise_scope :user do
    get '/me', to: 'sessions#current'
  end

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  }, controllers: {
    confirmations: 'confirmations',
    sessions: 'sessions',
    registrations: 'registrations'
  }
end
