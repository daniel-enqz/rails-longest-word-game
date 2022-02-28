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
