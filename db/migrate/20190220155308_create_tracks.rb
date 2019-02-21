class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :spotify_url
      t.string :href
      t.string :spotify_id
      t.string :preview_url
      t.string :uri
      t.integer :artist_id
      t.timestamps
    end
  end
end
