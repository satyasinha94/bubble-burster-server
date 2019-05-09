class Recommendation < ApplicationRecord
  extend RecommendationsHelper
  belongs_to :user

  def self.top_tracks_track_recs(user)
    user.refresh
    #BUG - user.tracks returning empty array, using User.find as workaround.
    track_ids = User.find(user.id).tracks.map{|track| track.spotify_id}.sample(5).join(",")
    header = {
      Authorization: "Bearer #{user.access_token}"
    }
    user_response = RestClient.get("https://api.spotify.com/v1/recommendations?market=US&seed_tracks=#{track_ids}", header)
    list = JSON.parse(user_response.body)
    recommendations_map(list["tracks"], user)
  end

  def self.top_artist_track_recs(user)
    user.refresh
    #BUG - self.artists returning empty array, using User.find as workaround.
    artist_ids = User.find(user.id).artists.map{|artist| artist.spotify_id}.sample(5).join(",")
    header = {
      Authorization: "Bearer #{user.access_token}"
    }
    user_response = RestClient.get("https://api.spotify.com/v1/recommendations?market=US&seed_artists=#{artist_ids}", header)
    list = JSON.parse(user_response.body)
    recommendations_map(list["tracks"], user)
  end

  def self.genre_recs(user)
    user.refresh
    genres = user.genres.map{|genre| genre.name}.sample(5).join(",")
    header = {
      Authorization: "Bearer #{user.access_token}"
    }
    user_response = RestClient.get("https://api.spotify.com/v1/recommendations?market=US&seed_genres=#{genres}", header)
    list = JSON.parse(user_response.body)
    recommendations_map(list["tracks"], user)
  end

end
