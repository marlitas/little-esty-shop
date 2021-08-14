Rails.application.routes.draw do
  root 'welcome#index'

  resources :customers
  resources :merchants, module: :merchant do
    resources :items
    resources :invoices
    resources :invoice_items
    resources :discounts
    get '/dashboard', to: 'merchants#dashboard'
  end

  resources :items, only: [:edit, :update, :new, :create]

  patch '/admin/merchants/update/:id', to: 'admin/merchants#update_status', as: 'update_status'

  namespace :admin do
    resources only: [:index]
    resources :merchants
    resources :invoices
  end
end
