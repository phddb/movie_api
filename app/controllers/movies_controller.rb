class MoviesController < ApplicationController

  # GET /movies 
  def index
    #@movies = Movie.all

    puts "params: #{params}"

    @query = params["query"] || "star wars"
    @page = params["page"] || 1


    base_url = "https://api.themoviedb.org/3/search/movie"

    # this API key probably shouldn't be committed to github.
    # If this weren't a toy example I'd put it somewhere else.
    api_key = "a99cc60fc2b34dbb18cb806b8a88ed14"


    # this call should probably have some error handling logic around it. 
    #  it would be nice to display a sensible message to the user if 
    #  api.themoviedb.org happens to be offline or something.
    resp = HTTParty.get("#{base_url}?api_key=#{api_key}&query=#{@query}&page=#{@page}")
    
    @movies = JSON.parse(resp.body)["results"]#.each{|mov| puts mov["title"]}
   
    @movies.each do |movie| 
      poster_path = movie["poster_path"]
      movie["image_url"] = image_url = "https://image.tmdb.org/t/p/w300#{poster_path}"
    end

  end

end
