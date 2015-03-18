class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.text :link_url
      t.text :synopsis
      t.string :username
      t.integer :year
      t.timestamps
    end
  end
end
