class Learner::MoviesController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'
  before_action :authenticate_learner_user!, only: [:create]

  def search
    @images = Movie.where.not(image_id: nil).shuffle.take(20)
    # インクリメンタルサーチ
    # unless params[:search_word].nil? 
    #   @movies = getMovies(params[:search_word])
    #   @movies.each do |movie|
    #     moveieDate = Movie.new(title: movie["title"], overview: movie["overview"], image_id: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}")
    #     @movies.push(moveieDate)
    #   end
    # end
  end
  
  def create
    @movies = []
    jsonMovies = getMovies(params[:search_word])
    jsonMovies.each do |movie|
      moveieDate = Movie.find_or_create_by(title: movie["title"], overview: movie["overview"], image_id: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}")
      @movies.push(moveieDate)
    end
  end
  
  def getMovies(search_word)
    componented = URI.escape(search_word)
    uri = URI.parse("https://api.themoviedb.org/3/search/movie?api_key=#{ENV['TMDB_API_KEY']}&language=ja&query=#{componented}&include_adult=false")
    json = Net::HTTP.get(uri) #NET::HTTPを利用してAPIを叩く
    result = JSON.parse(json) #返ってきたjsonデータをrubyの配列に変換
    return result["results"]
  end
end
