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
    @result = if @guess.chars.all? { |letter| @guess.count(letter) <= @letters.count(letter.upcase) }
                'Congratulations! ${@guess} is a valid English word!'
              else
                'NOT VALID'
              end
  end
end
