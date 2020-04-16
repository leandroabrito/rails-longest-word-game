class PagesController < ApplicationController

  def new
    @chars_arr = []
    8.times do
      @chars_arr << ("a".."z").to_a.sample
    end
    @chars_arr
  end

  def score
    @word = params[:word]
  end
end
