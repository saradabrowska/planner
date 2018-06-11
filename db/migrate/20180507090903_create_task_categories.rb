class CreateTaskCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :task_categories do |t|
      t.string :name
      t.string :color
      t.timestamps
    end
  end
end
