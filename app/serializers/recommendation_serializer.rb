class RecommendationSerializer < ActiveModel::Serializer
  attributes :name, :spotify_url, :href, :spotify_id, :preview_url, :uri, :artist_name
end
