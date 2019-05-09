class Api::V1::RecommendationsController < ApplicationController
  def index
    render json: curr_user.recommendations.sample(20)
  end

  def tracks
    render json: Recommendation.top_tracks_track_recs(curr_user).sample(20)
  end

  def artists
    render json: Recommendation.top_artist_track_recs(curr_user).sample(20)
  end

  def genres
    render json: Recommendation.genre_recs(curr_user).sample(20)
  end

end
