Rails.application.routes.draw do

  namespace :admin do
  	devise_for :admin, controllers: {
      sessions: 'admin/sessions',
      registrations: 'admin/registrations',
      passwords: 'admin/passwords'
    }
  	root to: "homes#top"
  	resources :items, only:[:index, :new, :create, :show, :edit, :update]
  	resources :genres, only:[:index, :create, :edit, :update]
  	resources :end_users, only:[:index, :show, :edit, :update]
  	resources :orders, only:[:index, :show, :update] do
  		resources :order_details, only:[:update]
  	end
  end

  scope module: :public do
  	devise_for :end_users, controllers: {
      sessions: 'public/sessions',
      registrations: 'public/registrations',
      passwords: 'public/passwords'
    }
  	root to: "homes#top"
  	get "/about", to: "homes#about"
  	resources :items, only:[:index, :show]
  	get "/end_users/unsubscribe", to: "end_users#unsubscribe"
  	patch "/end_users/withdraw", to: "end_users#withdraw"
  	resource :end_user, only:[:show, :edit, :update]
  	delete "cart_items/destroy_all", to: "end_users#destroy_all", as: "destroy_all"
  	resources :cart_items, only:[:index, :update, :destroy, :create]
  	post "/orders/comfirm", to: "orders#comfirm"
  	get "/orders/thanks", to: "orders#thanks"
  	resources :orders, only:[:new, :create, :index, :show]
  	resources :addresses, only:[:index, :edit, :create, :update, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
