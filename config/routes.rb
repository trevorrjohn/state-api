Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :addresses, only: %i[create update destroy]
    end
  end
end
