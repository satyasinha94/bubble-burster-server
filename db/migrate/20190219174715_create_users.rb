class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
    t.string :spotify_id
    t.string :access_token
    t.string :refresh_token
    t.string :spotify_url
    t.string :profile_img_url
    t.string :href
    t.string :uri
    t.string :username

      t.timestamps
    end
  end
end
