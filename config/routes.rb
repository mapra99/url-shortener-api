require 'sidekiq/web'
require 'sidekiq/cron/web'
require_relative "routes/short_url_constraint"

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :short_urls, only: [:create] do
        collection do
          get 'stats'
        end
      end
    end
  end

  constraints(ShortUrlConstraint) do
    match "*short_url", to: "api/v1/short_urls#redirect", via: :get
  end

  mount Sidekiq::Web => "/sidekiq"
end
