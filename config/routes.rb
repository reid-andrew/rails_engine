Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items do
        resources :merchant, module: :items, only: [:index]
      end
      resources :merchants do
        resources :items, module: :merchants, only: [:index]
      end
    end
  end
end
