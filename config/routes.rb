# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  resources :sheds, only: %i[show new create edit update]
end
