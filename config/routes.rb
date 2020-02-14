Rails.application.routes.draw do
  get '/studios', to: 'studios#index'
  get '/actors/:actor_id', to: 'actors#show'
  get '/movies/:movie_id', to: 'movies#show'
  patch '/movies/:movie_id', to: 'movies#add_actor'
end
