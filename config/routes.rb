Rails.application.routes.draw do
  mount_devise_token_auth_for 'Admin', at: 'auth'
  namespace :api do
    namespace :v1 do
      namespace :admin do
        resources :publishing_companies do
          resources :books
        end

        resources :authors
      end

      resources :books, only: [:index, :show]
    end
  end
end
