Rails.application.routes.draw do
  get '/studios', to: 'studios#index'
  get '/actors/:actor_id', to: 'actors#show'
  get '/movies/:movie_id', to: 'movies#show'
end
