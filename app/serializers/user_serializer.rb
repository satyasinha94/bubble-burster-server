class UserSerializer < ActiveModel::Serializer
  attributes :username, :spotify_url, :profile_img_url
  has_many :user_artists
  has_many :user_tracks
  has_many :genres
  has_many :artists
  has_many :tracks
end
