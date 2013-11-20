Shop3::Application.routes.draw do

  get 'payments/cancel'
  match 'payments/success', via: [:get, :post]
  match 'payments/notify', via: [:get, :post, :put]

  resources :item_users, only: [:index, :create, :destroy, :update]
  devise_for :users
  resources :comments, only: [:new, :create]
  resources :items
  root 'welcome#index'
  resources :categories
  resources :posts
  resources :orders, only: [:index, :create, :show]

  get 'about' => 'about#index'
  get 'about/team'
  get 'contacts' => 'about#contacts'
  get "trololo" => "about#na"

end
