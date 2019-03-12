class Api::V1::GenresController < ApplicationController
  def index
    render json: curr_user.genres
  end
end
