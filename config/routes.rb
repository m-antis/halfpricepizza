Rails.application.routes.draw do
  
  get '/rangers' => 'rangers#index'
  get '/nets' => 'brooklyn_pizza#index'

	devise_for :users, :controllers => {registrations: 'registrations'}
	devise_scope :user do
	  	authenticated :user do
	    	root :to => 'rangers#index', as: :authenticated_root
	    	# root :to => 'brooklyn_pizza#index', as: :authenticated_root

	  	end
	  	unauthenticated :user do
	    	root :to => 'devise/registrations#new', as: :unauthenticated_root
	  	end
	end
end
