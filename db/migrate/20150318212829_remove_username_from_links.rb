class RemoveUsernameFromLinks < ActiveRecord::Migration
  def change
    remove_column :links, :username, :string
  end
end
