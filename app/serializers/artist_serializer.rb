class ArtistSerializer < ActiveModel::Serializer
  attributes :name, :spotify_url, :href, :spotify_id, :uri, :img_url
  has_many :tracks
  has_many :genres
  has_many :user_artists, key: :UserArtists
end
