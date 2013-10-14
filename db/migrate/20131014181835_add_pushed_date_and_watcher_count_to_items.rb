class AddPushedDateAndWatcherCountToItems < ActiveRecord::Migration
  def change
    add_column :items, :watchers, :string
    add_column :items, :last_push_date, :datetime
  end
end
