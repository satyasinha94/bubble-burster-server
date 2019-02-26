class GenresController < ApplicationController
  def index
    
    render json: curr_user.genres
  end
end
