class TrackSerializer < ActiveModel::Serializer
  attributes :name, :spotify_url, :href, :spotify_id, :preview_url, :uri, :artist_id
  belongs_to :artist
  has_many :user_tracks, key: :UserTracks
end
