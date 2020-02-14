class ActorsController < ApplicationController
  def show
    @actor = Actor.find(params[:actor_id])
  end
end
