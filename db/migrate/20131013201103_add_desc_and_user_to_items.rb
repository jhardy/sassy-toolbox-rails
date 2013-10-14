class AddDescAndUserToItems < ActiveRecord::Migration
  def change
    add_column :items, :description, :text
    add_column :items, :user, :string
  end
end
