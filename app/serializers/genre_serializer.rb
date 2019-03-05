class GenreSerializer < ActiveModel::Serializer
  attributes :name
  has_many :artists
  has_many :tracks
  has_many :user_genres
end
