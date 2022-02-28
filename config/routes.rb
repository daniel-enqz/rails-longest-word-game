Rails.application.routes.draw do
  root 'articles#index'
  get '/new', to: 'games#new'
  post '/score', to: 'games#score'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
end
