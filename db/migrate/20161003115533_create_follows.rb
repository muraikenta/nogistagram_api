class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.references :from_user, index: true, foreign_key: true
      t.references :to_user, index: true, foreign_key: true
      t.integer :state, default: 1

      t.timestamps null: false
    end
  end
end
