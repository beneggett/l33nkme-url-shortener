class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :url
      t.string :shorturl
      t.datetime :date_created
      t.integer :clicks

      t.timestamps
    end
  end
end
