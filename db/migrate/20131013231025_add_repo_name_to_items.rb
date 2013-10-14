class AddRepoNameToItems < ActiveRecord::Migration
  def change
    add_column :items, :reponame, :string
  end
end
