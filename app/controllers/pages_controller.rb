require 'open-uri'
require 'json'

class PagesController < ApplicationController

  def new
    @chars_arr = generate_grid
  end

  def score
    @grid = params[:grid].gsub('"', "")
    @word = params[:word]
    @exists = word_exists?(@word)
    @in_grid = in_grid?(@word, @grid)

  end

  private

  def word_exists?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    html_file = open(url).read
    word_hash = JSON.parse(html_file)
    @found_word = word_hash["found"].to_s
    @found_word
  end

  def in_grid?(word, grid)
    boolean_arr = []
    word_arr = word.chars
    word_arr.each { |char| grid.include?(char) ? boolean_arr << true : boolean_arr << false }
    trues = boolean_arr.select { |char| char == true }
    trues.size == word_arr.size
  end

  def generate_grid
    chars_arr = []
    8.times do
      chars_arr << ("a".."z").to_a.sample
    end
    chars_arr
  end
end
