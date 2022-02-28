class GamesController < ApplicationController
  def new
    range = ("A".."Z").to_a
    @letters = []
    9.times { @letters.push(range.sample) }
    @letters
  end

  def score
    raise
  end
end
