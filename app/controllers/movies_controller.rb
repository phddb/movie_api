class MoviesController < ApplicationController

  # GET /movies or /movies.json
  def index
    #@movies = Movie.all

    puts "params: #{params}"

    query = params["query"]

    base_url = "https://api.themoviedb.org/3/search/movie"
    api_key = "a99cc60fc2b34dbb18cb806b8a88ed14"
    page = params["page"]

    resp = HTTParty.get("#{base_url}?api_key=#{api_key}&query=#{query}&page=#{page}")

    @movies = JSON.parse(resp.body)["results"]#.each{|mov| puts mov["title"]}
   
    @movies.each do |movie| 
      poster_path = movie["poster_path"]
      movie["image_url"] = image_url = "https://image.tmdb.org/t/p/w500#{poster_path}"
    end

  end

  # GET /movies/1 or /movies/1.json
  def show
  end

end
