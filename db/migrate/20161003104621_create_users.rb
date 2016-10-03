class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :unique_name
      t.string :email
      t.text :introduction
      t.string :website
      t.integer :gender
      t.string :image_url
      t.integer :privacy_type

      t.timestamps null: false
    end
  end
end
