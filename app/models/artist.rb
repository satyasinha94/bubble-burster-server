class Artist < ApplicationRecord
  has_many :tracks
  has_many :artist_genres
  has_many :genres, through: :artist_genres
  has_many :user_artists
  has_many :users, through: :user_artists

  def self.artist_model(artists, user)
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
        user_id: user.id,
        artist_id: new_artist.id,
        popularity: artist["popularity"],
        username: user.username
      )
      artist["genres"].map do |genre|
        new_genre = Genre.find_or_create_by(
          name: genre
        )
        ArtistGenre.find_or_create_by(
          artist_id: new_artist.id,
          genre_id: new_genre.id
        )
        ug = UserGenre.find_or_create_by(
          popularity: artist["popularity"],
          artist_count: 1,
          user_id: user.id,
          genre_id: new_genre.id,
          username: user.username
        )
          ug.update(popularity: ug.popularity += artist["popularity"])
          ug.update(artist_count: ug.artist_count += 1 )
      end
    end
  end

end
