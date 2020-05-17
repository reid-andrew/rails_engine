Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        resources :find, only: [:index]
      end
      namespace :items do
        resources :find, only: [:index]
        resources :find_all, only: [:index]
      end
      resources :items do
        resources :merchant, module: :items, only: [:index]
      end
      resources :merchants do
        resources :items, module: :merchants, only: [:index]
      end
    end
  end
end
