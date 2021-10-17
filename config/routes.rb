# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  resources :contact_imports
  devise_for :users
  root to: 'contact_imports#index'

  mount Sidekiq::Web => '/sidekiq'
end
