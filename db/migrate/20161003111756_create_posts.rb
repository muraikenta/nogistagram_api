class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :image_url
      t.text :body
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
