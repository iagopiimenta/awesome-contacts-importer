# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  resources :contacts
  resources :contact_imports do
    resources :contacts, only: [:index]
    resources :contact_faileds, only: [:index]
  end

  devise_for :users

  root to: 'contact_imports#index'
  mount Sidekiq::Web => '/sidekiq'
end
