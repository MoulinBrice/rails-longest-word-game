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
    @sav_letters = @letters
  end

  def score
    @answer = ""
    @word = params[:word]
    @letters = params[:letters]

     # Test1 Le mot ne peut pas être créé à partir de la grille d’origine.
     goodWord = true
     @word.split("").each do |letter|
       @word.include?(letter) ? goodWord = true : goodWord = false
       break letter if goodWord = false
     end

    if goodWord
      url = "https://wagon-dictionary.herokuapp.com/#{@word}"
      word_serialized = URI.open(url).read
      back_word = JSON.parse(word_serialized)

      if !back_word[:found]
        # Le mot est valide d’après la grille, mais ce n’est pas un mot anglais valide.
        @answer = "Sorry but <strong>#{@word}</strong> does not seem to be a valid English word..."
      else
        # Le mot est valide d’après la grille et est un mot anglais valide.
        @answer = "<strong>Congratulation!</strong> #{@word} is a valid English word!"
      end
    else
      # Test1 Le mot ne peut pas être créé à partir de la grille d’origine.
      @answer = "Sorry but <strong>#{@word}</strong> can't be build out of #{@letters.split("").join(",")}"
    end
  end
end
