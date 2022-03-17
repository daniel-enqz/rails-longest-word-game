![image](https://user-images.githubusercontent.com/72522628/158726577-9e2aab03-62d7-4e4b-bf23-f9642f799d00.png)

```ruby
Rails.application.routes.draw do
  root 'games#new'
  get '/new', to: 'games#new'
  post '/score', to: 'games#score'
  get '/result', to: 'games#result'
  get '/show', to: 'games#show'
end
```
