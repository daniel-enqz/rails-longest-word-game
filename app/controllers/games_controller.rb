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
    if guess.chars.all? { |letter| guess.count(letter) <= letters.count(letter.upcase) } && user['found'] == true
      "Congratulations! #{guess} is a valid English word!"
    elsif user['found'] == false
      'not an english word'
    else
      "Sorry, but #{@guess} can't be build out of the grid"
    end
  end

  def result
    @result = params[:message]
  end
end
