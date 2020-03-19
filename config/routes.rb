Rails.application.routes.draw do
	# get "logout" => "sessions#destroy", :as => "logout"
	get "login" => "sessions#new", :as => "login"
	get "signup" => "users#new", :as => "signup"
	get "secret" => "pages#secret", :as => "secret"
	delete "logout" => "sessions#destroy", :as => "logout"
	root :to => "posts#index"
	resources :posts
	resources :users
	resources :sessions
	resources :password_resets
end
