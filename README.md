# Simple Rails App Where users need to select the longest english word posible out from a random set of letters in a GRID
## Main App Features
> A user word was checked with different tests and received a score depending on the length of the word.
> The word was also checked to be an english word by parsing a JSON file.
![image](https://user-images.githubusercontent.com/72522628/158726577-9e2aab03-62d7-4e4b-bf23-f9642f799d00.png)

`routes.rb`
```ruby
Rails.application.routes.draw do
  root 'games#new'
  get '/new', to: 'games#new'
  post '/score', to: 'games#score'
  get '/result', to: 'games#result'
  get '/show', to: 'games#show'
end
```
`games_controller.rb`
```ruby
require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    range = ("A".."Z").to_a
    @letters = []
    9.times { @letters.push(range.sample) }
    @letters
  end

  def score
    @guess = params[:guess]
    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)
    @result = analysis(user, @guess, @letters)
    redirect_to result_path(message: @result)
  end

  def analysis(user, guess, letters)
    session[:past_wins] ||= []
    if guess.chars.all? { |letter| guess.count(letter) <= letters.count(letter.upcase) } && user['found'] == true
      session[:past_wins] << guess.length
      "Congratulations! #{guess} is a valid English word!"
    elsif user['found'] == false
      session[:past_wins] << 0
      'not an english word'
    else
      session[:past_wins] << 0
      "Sorry, but #{@guess} can't be build out of the grid"
    end
  end

  def result
    @result = params[:message]
  end

  def show
    @final_score = session[:past_wins].sum
  end
end
```

### CHECK NEXT STEPS TO DEPLOY

## Things you may want to cover to initialize this project:
### Versions
> <img src="https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white"> <strong> 3.0.3p157 (2021-11-24 revision 3fb7d2cadc) [x86_64-linux]</strong><br>
> <img src="https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white"> <strong> 7.0.2.2 </strong>

## Setup

```shell
 git clone git@github.com:daniel-enqz/rails-task-manager.git
 cd rails-task-manager
 rails db:create db:migrate db:seed:replant
 bundle install
 yarn install
 rails server
```
Open you browser and visit `localhost:3000`
