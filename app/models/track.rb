class Track < ApplicationRecord
  has_many :user_tracks
  has_many :users, through: :user_tracks
  belongs_to :artist, optional: true

  def self.track_model(tracks, user)
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
        user_id: user.id,
        track_id: new_track.id,
        popularity: track["popularity"],
        username: user.username
      )
    end
  end

end
