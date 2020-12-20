Rails.application.routes.draw do
  mount_devise_token_auth_for 'Admin', at: 'auth'
  namespace :api do
    namespace :v1 do
      namespace :admin do
        resources :authors, except: [:index, :show]
        resources :books, except: [:index, :show]
        resources :genre, except: [:index, :show] 
        resources :publishing_companies, except: [:index, :show]
      end

      resources :authors, only: [:index, :show]
      resources :books, only: [:index, :show]
      resources :genre, only: [:index, :show] 
      resources :publishing_companies, only: [:index, :show]
    end
  end
end
