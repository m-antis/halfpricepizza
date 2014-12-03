Rails.application.routes.draw do
  
  root 'brooklyn_pizza#index'
  post 'twilio/voice' => 'twilio#voice'
  get '/rangers' => 'rangers#index'

end
