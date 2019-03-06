class CreateRecommendations < ActiveRecord::Migration[5.2]
  def change
    create_table :recommendations do |t|
      t.integer :user_id
      t.string :name
      t.string :spotify_url
      t.string :href
      t.string :spotify_id
      t.string :preview_url
      t.string :uri
      t.string :artist_name
      t.integer :popularity
      t.string :album_cover
      t.timestamps
    end
  end
end
