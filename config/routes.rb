Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :wheather do
        collection do
          get :historical
          get :current
          get "/historical/min", to: 'wheather#min'
          get "/historical/max", to: 'wheather#max'
          get "/historical/avg", to: 'wheather#avg'
          get "/by_time/:epochTime", to: 'wheather#by_time'
        end
      end
      resources :health, only: :index
    end
  end
end
