Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :urls, only: [ :index, :show, :create ]
    end
  end

  get "/:short_url", to: "redirects#show", as: :short
end
