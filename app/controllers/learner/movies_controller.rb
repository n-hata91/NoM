class Learner::MoviesController < ApplicationController

  def search
    @movies = Movie.all.shuffle.take(2)
  end

  def create
  end
  
end
