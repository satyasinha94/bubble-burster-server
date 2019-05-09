class User < ApplicationRecord
  has_many :user_tracks, dependent: :destroy
  has_many :tracks, through: :user_tracks
  has_many :user_artists, dependent: :destroy
  has_many :artists, through: :user_artists
  has_many :genres, through: :artists
  has_many :recommendations, dependent: :destroy

  def expired
    (Time.now - self.updated_at.localtime) > 3300
  end

  def refresh
    body = {
      grant_type: "refresh_token",
      refresh_token: self.refresh_token,
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV["CLIENT_SECRET"]
    }
    # Send request and updated user's access_token
    auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
    auth_params = JSON.parse(auth_response)
    self.update(access_token: auth_params["access_token"])
  end

  def expires_in
    3300 - (Time.now - self.updated_at.localtime)
  end

  def user_spotify_data
    self.refresh
    self.my_artists
    self.my_tracks
  end

  def my_tracks
    self.refresh
    header = {
      Authorization: "Bearer #{self.access_token}"
    }
    user_response = RestClient.get("https://api.spotify.com/v1/me/top/tracks", header)
    list = JSON.parse(user_response.body)["items"]
    Track.track_model(list, self)
  end

  def my_artists
    self.refresh
    header = {
      Authorization: "Bearer #{self.access_token}"
    }
    user_response = RestClient.get("https://api.spotify.com/v1/me/top/artists", header)
    list = JSON.parse(user_response.body)["items"]
    Artist.artist_model(list, self)
  end

end
