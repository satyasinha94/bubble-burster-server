class ApplicationController < ActionController::Base

  def encode_token(user_id)
    JWT.encode({user_id: user_id}, ENV['JWT_SECRET'])
  end

  def token
    request.headers["Authorization"]
  end

  def decode_token
    JWT.decode(token, ENV['JWT_SECRET'])[0]["user_id"].values[0]
  end

  def curr_user
    @curr_user = User.find_by(id: decode_token)
  end

end
