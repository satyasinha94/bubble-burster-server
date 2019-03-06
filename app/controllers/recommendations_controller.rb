class RecommendationsController < ApplicationController
  def index
    render json: curr_user.recommendations.sample(20)
  end

  def tracks
    render json: curr_user.top_artist_track_recs.sample(20)
  end

  def artists
    render json: curr_user.top_tracks_track_recs.sample(20)
  end

  def genres
    render json: curr_user.genre_recs.sample(20)
  end

end
