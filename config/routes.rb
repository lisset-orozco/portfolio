# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/health_check', to: proc { [200, {}, ['success']] }

  namespace :v1 do
    resources :portfolios, only: :create do
      get :profit, on: :member
      
      post '/stocks/', to: 'stocks#create'
      get '/stocks/:symbol/price', to: 'stocks#price'
    end

    get '/stocks/:symbol/price', to: 'stocks#market_price'
  end 
end
