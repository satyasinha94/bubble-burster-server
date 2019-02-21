class TrackSerializer < ActiveModel::Serializer
  attributes :name, :spotify_url, :href, :spotify_id, :preview_url, :uri, :spotify_artist_id, :artist_id
  belongs_to :artist
end
