class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :full_link, null: false
      t.string :shorten_link
      t.integer :click_count, default: 0


      t.timestamps
    end
  end
end
