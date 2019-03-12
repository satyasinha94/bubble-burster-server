class Api::V1::TracksController < ApplicationController
  def index
    render json: curr_user.tracks
  end
end
