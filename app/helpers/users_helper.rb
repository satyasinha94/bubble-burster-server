module UsersHelper
  # Can use one method for all recommendation mapping

  # def recommendations_map(list)
  #   list.map do |data|
  #     Recommendation.find_or_create_by(
  #       user_id: self.id,
  #       name: data["name"],
  #       spotify_url: data["external_urls"]["spotify"],
  #       spotify_id: data["id"],
  #       uri: data["uri"],
  #       artist_name: data["artists"][0]["name"],
  #       popularity: data["popularity"],
  #       album_cover: data["album"]["images"][0]["url"]
  #     )
  # end

end
