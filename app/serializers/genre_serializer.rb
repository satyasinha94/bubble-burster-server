class GenreSerializer < ActiveModel::Serializer
  attributes :name
  has_many :artists
  has_many :tracks
end
