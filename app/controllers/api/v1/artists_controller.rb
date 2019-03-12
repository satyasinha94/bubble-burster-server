class Api::V1::ArtistsController < ApplicationController
  def index
    render json:  curr_user.artists
  end
end
