class User < ApplicationRecord
  has_many :user_tracks, dependent: :destroy
  has_many :tracks, through: :user_tracks
  has_many :user_artists, dependent: :destroy
  has_many :artists, through: :user_artists
  has_many :genres, through: :artists
  has_many :recommendations

  def expired
    (Time.now - self.updated_at.localtime) > 3300
  end

  def refresh
      if (expired)
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
    else
      puts "token still valid, time remaining: #{3300 - (Time.now - self.updated_at.localtime)}"
    end
  end

  def user_spotify_data
    self.refresh
    self.my_artists
    self.my_tracks
    self.top_tracks_track_recs
    self.top_artist_track_recs
  end

  def my_tracks
    self.refresh
    header = {
      Authorization: "Bearer #{self.access_token}"
    }
    user_response = RestClient.get("https://api.spotify.com/v1/me/top/tracks", header)
    list = JSON.parse(user_response.body)["items"]
    self.track_model(list)
  end

  def my_artists
    self.refresh
    header = {
      Authorization: "Bearer #{self.access_token}"
    }
    user_response = RestClient.get("https://api.spotify.com/v1/me/top/artists", header)
    list = JSON.parse(user_response.body)["items"]
    self.artist_model(list)
  end

  def track_model(tracks)
    tracks.map do |track|
      new_track = Track.find_or_create_by(
        name: track["name"],
        spotify_url: track["external_urls"]["spotify"],
        href: track["href"],
        spotify_id: track["id"],
        preview_url: track["preview_url"],
        uri: track["uri"],
        artist_id: Artist.find_by(spotify_id: track["artists"][0]["id"]) === nil ? nil : Artist.find_by(spotify_id: track["artists"][0]["id"]).id
      )
      UserTrack.find_or_create_by(
        user_id: self.id,
        track_id: new_track.id,
        popularity: track["popularity"],
        username: self.username
      )
    end
  end

  def artist_model(artists)
    artists.map do |artist|
      new_artist = Artist.find_or_create_by(
        name: artist["name"],
        spotify_url: artist["external_urls"]["spotify"],
        href: artist["href"],
        spotify_id: artist["id"],
        img_url: artist["images"][0]["url"],
        uri: artist["uri"]
      )
      UserArtist.find_or_create_by(
        user_id: self.id,
        artist_id: new_artist.id,
        popularity: artist["popularity"],
        username: self.username
      )
      artist["genres"].map do |genre|
        new_genre = Genre.find_or_create_by(
          name: genre
        )
        ArtistGenre.find_or_create_by(
          artist_id: new_artist.id,
          genre_id: new_genre.id
        )
      end
    end
  end

  def top_artist_track_recs
    self.refresh
    artist_ids = self.artists.map{|artist| artist.spotify_id}.take(5).join(",")
    byebug
    header = {
      Authorization: "Bearer #{self.access_token}"
    }
    user_response = RestClient.get("https://api.spotify.com/v1/recommendations?market=US&seed_artists=#{artist_ids}", header)
    list = JSON.parse(user_response.body)
    list["tracks"].map do |data|
      Recommendation.find_or_create_by(
        user_id: self.id,
        name: data["name"],
        spotify_url: data["external_urls"]["spotify"],
        href: data["href"],
        spotify_id: data["id"],
        preview_url: data["preview_url"],
        uri: data["uri"],
        artist_name: data["artists"][0]["name"],
        popularity: data["popularity"]
      )
    end
  end

  def top_tracks_track_recs
    self.refresh
    track_ids = self.tracks.map{|track| track.spotify_id}.take(5).join(",")
    header = {
      Authorization: "Bearer #{self.access_token}"
    }
    user_response = RestClient.get("https://api.spotify.com/v1/recommendations?market=US&seed_tracks=#{track_ids}", header)
    list = JSON.parse(user_response.body)
    list["tracks"].map do |data|
      Recommendation.find_or_create_by(
        user_id: self.id,
        name: data["name"],
        spotify_url: data["external_urls"]["spotify"],
        href: data["href"],
        spotify_id: data["id"],
        preview_url: data["preview_url"],
        uri: data["uri"],
        artist_name: data["artists"][0]["name"],
        popularity: data["popularity"]
      )
      end
  end

end
