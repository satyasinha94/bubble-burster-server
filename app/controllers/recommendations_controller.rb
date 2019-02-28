class RecommendationsController < ApplicationController
  def index
    render json: curr_user.recommendations
  end

  def tracks
    render json: curr_user.top_artist_track_recs
  end

  def artists
    render json: curr_user.top_tracks_track_recs
  end
end
