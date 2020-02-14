class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:movie_id])
  end

  def add_actor
    movie = Movie.find(params[:movie_id])
    actor = Actor.find_by!(name: params[:name])
    movie.actors << actor
    redirect_to "/movies/#{movie.id}"
  end
end
