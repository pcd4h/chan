class AddInProgressToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :in_progress, :boolean, :default => false
  end
end
