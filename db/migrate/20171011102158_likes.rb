class Likes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.string :name
      t.string :url
      t.string :img
      t.timestamps null: false
    end
  end
end
