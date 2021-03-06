class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.datetime :start_time
      t.boolean :completed, default: false
      t.string :description
      t.timestamps
    end
  end
end
