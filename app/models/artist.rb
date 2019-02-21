class Artist < ApplicationRecord
  has_many :tracks
  has_many :artist_genres
  has_many :genres, through: :artist_genres
end
