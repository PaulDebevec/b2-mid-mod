class Actor < ApplicationRecord
  validates_presence_of :name, :age

  has_many :actor_movies
  has_many :movies, through: :actor_movies

  def associates
    # I still need work on joins. Not really sure how to do this one.

    # require "pry"; binding.pry
    # Movie.select(:title).joins(:actor_movies).distinct
    # Actor.select(:name).joins(:actor_movies).where("actor_id = movie.id")
  end
end
