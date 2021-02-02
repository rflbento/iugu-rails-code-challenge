Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace 'api' do
    namespace 'v1' do
      resources :accounts, only: [:create]
      get '/accounts/:account_number/balance', to: 'balances#index', as: 'balance'

      resources :transfers, only: [:create]

      resources :user_usages, only: [:index]
    end
  end
end
