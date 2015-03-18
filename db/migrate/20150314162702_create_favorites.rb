class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.string :link_id
      t.string :title
    end
  end
end
