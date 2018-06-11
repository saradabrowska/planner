class AddTaskCategoryToTasks < ActiveRecord::Migration[5.1]
  def change
    add_reference :tasks, :task_category, foreign_key: true
  end
end
