class ArtistsController < ApplicationController
  def index
    render json:  curr_user.artists
  end
end
