class User < ApplicationRecord
  has_many :user_tracks, dependent: :destroy
  has_many :tracks, through: :user_tracks
  has_many :user_artists, dependent: :destroy
  has_many :artists, through: :user_artists
  has_many :genres, through: :artists

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
        popularity: track["popularity"]
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
        popularity: artist["popularity"]
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

end
