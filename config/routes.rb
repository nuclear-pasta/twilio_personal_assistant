Rails.application.routes.draw do
  match '/twilio/index', to: 'twilio#index', via: [:get, :post]
  get '/messages', to: 'twilio#index'
  post '/messages', to: 'twilio#create'
  get '/inbox', to: 'inbox#index'
  get '/inbox/:id', to: 'inbox#show'
  get '/twilio/make_call', to: 'twilio#make_call', as: 'make_call'   #should be a post request but since is only for test
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end