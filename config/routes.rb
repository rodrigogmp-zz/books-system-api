Rails.application.routes.draw do
  get '/' => "api/v1/books#index", :defaults => { :format => 'json' }
  mount_devise_token_auth_for 'Admin', at: 'auth'
  namespace :api do
    namespace :v1 do
      namespace :admin do
        resources :authors, except: [:index, :show]
        resources :books, except: [:index, :show]
        resources :genres, except: [:index, :show] 
        resources :publishing_companies, except: [:index, :show]
      end

      resources :authors, only: [:index, :show] do
        member do
          get :books
        end
      end
      resources :books, only: [:index, :show]
      resources :genres, only: [:index, :show] do
        member do
          get :books
        end
      end
      resources :publishing_companies, only: [:index, :show] do
        member do
          get :books
        end
      end
    end
  end
end
