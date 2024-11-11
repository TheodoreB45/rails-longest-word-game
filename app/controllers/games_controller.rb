require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    @alphabet = ('A'..'Z').to_a
    @letters = Array.new(10) { @alphabet.sample }
  end

  def score
    @word = params[:word]
    if included?(@word, params[:grid]) == false
      @result = "Sorry but #{@word} can't be built out of #{params[:grid]}"
    elsif english_word?(@word) == false
      @result = "Sorry but #{@word} does not seem to be a vaild English word..."
    else
      @result = "Congratulations! #{@word} is a vaild English word!"
    end
  end
end

private

def included?(guess, grid)
  guess.upcase.chars.all? do |letter|
    guess.upcase.count(letter) <= grid.count(letter)
  end
end

def english_word?(word)
  response = URI.parse("https://dictionary.lewagon.com/#{word}")
  json = JSON.parse(response.read)
  json['found']
end
