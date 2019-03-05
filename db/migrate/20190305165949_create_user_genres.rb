class CreateUserGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :user_genres do |t|
      t.integer :user_id
      t.integer :genre_id
      t.integer :popularity
      t.integer :artist_count
      t.string :genre_name
      t.string :username
      t.timestamps
    end
  end
end
