class GamesController < ApplicationController
  def new
    @letters = []
    9.times { @letters < rand(A..Z) }
  end

  def score
  end
end
