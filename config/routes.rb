Rails.application.routes.draw do
  
  get '/rangers' => 'rangers#index'

	devise_for :users
	devise_scope :user do
	  	authenticated :user do
	    	root :to => 'brooklyn_pizza#index', as: :authenticated_root
	  	end
	  	unauthenticated :user do
	    	root :to => 'devise/registrations#new', as: :unauthenticated_root
	  	end
	end
end
