class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :taskid
      t.string :url
      t.string :assignee
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
