class TracksController < ApplicationController
  def index
    render json: curr_user.tracks
  end
end
