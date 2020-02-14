class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:movie_id])
  end
end
