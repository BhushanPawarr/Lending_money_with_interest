require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  devise_for :users
  root 'homes#index'

  resources :users, only: [:show, :new] do
    resources :loans, only: [:new, :create], controller: 'users' do
      member do
         get 'view_adjustments'
         get 'loans/:id/adjustments', to: 'admin#view_adjustments', as: :loan_adjustments
         get 'adjustments', to: 'adjustments#index'

        patch 'accept_loan'
        patch 'reject_loan'
        patch 'repay_loan'
        patch 'accept_adjustment'
        patch 'reject_adjustment'
        patch 'request_readjustment'
        patch 'reject_readjustment'
      end
    end
  end

  post 'request_loan', to: 'users#request_loan'
  get 'adjustments', to: 'adjustments#index'

  # Admin-specific routes
  get 'dashboard', to: 'admin#dashboard'
  patch 'approve_loan/:id', to: 'admin#approve_loan', as: :approve_loan
  patch 'reject_loan/:id', to: 'admin#reject_loan', as: :reject_loan
  patch 'adjust_loan/:id', to: 'admin#adjust_loan', as: :adjust_loan
  patch 'handle_readjustment_request/:id', to: 'admin#handle_readjustment_request', as: :handle_readjustment_request
  get 'loans/:id', to: 'admin#show_loan', as: :show_loan
end
