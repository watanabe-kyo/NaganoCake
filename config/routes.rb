Rails.application.routes.draw do

    devise_for :admin, controllers: {
      sessions: 'admin/sessions',
      registrations: 'admin/registrations',
      passwords: 'admin/passwords'
    }
  namespace :admin do
  	root to: "homes#top"
  	resources :items, only:[:index, :new, :create, :show, :edit, :update]
  	resources :genres, only:[:index, :create, :edit, :update]
  	resources :end_users, only:[:index, :show, :edit, :update]
  	resources :orders, only:[:index, :show, :update] do
  		resources :order_details, only:[:update]
  	end
  end

  scope module: :public do
    devise_for :end_users, skip:'registrations'
    devise_scope :end_user do
      get 'end_users/signup' => 'registrations#new', as: :new_end_user_registration
      post 'end_users/signup' => 'registrations#create', as: :end_user_registration
      get 'user' => 'registrations#edit', as: :edit_user_registration
      patch 'user' => 'registrations#update', as: nil
    end
  	root to: "homes#top"
  	get "/about", to: "homes#about"
  	resources :items, only:[:index, :show]
  	get "/end_users/unsubscribe", to: "end_users#unsubscribe"
  	patch "/end_users/withdraw", to: "end_users#withdraw"
  	resource :end_users, only:[:show, :edit, :update]
  	delete "cart_items/destroy_all", to: "end_users#destroy_all", as: "destroy_all"
  	resources :cart_items, only:[:index, :update, :destroy, :create]
  	post "/orders/comfirm", to: "orders#comfirm"
  	get "/orders/thanks", to: "orders#thanks"
  	resources :orders, only:[:new, :create, :index, :show]
  	resources :addresses, only:[:index, :edit, :create, :update, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
