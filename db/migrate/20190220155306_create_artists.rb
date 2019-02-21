class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :spotify_url
      t.string :href
      t.string :spotify_id
      t.string :uri
      t.string :img_url
      t.timestamps
    end
  end
end
