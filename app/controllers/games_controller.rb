require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = []
    letter_tab = []
    letter_tab = ("A".."Z").take(26)
    10.times{
      @letters << letter_tab[rand(0..letter_tab.length)]
    }
  end

  def score
    @word=params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_serialized = URI.open(url).read
    back_word = JSON.parse(word_serialized)



    puts "#{user["name"]} - #{user["bio"]}"

  end



end
