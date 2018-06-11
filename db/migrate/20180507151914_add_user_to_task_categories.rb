class AddUserToTaskCategories < ActiveRecord::Migration[5.1]
  def change
    add_reference :task_categories, :user, foreign_key: true
  end
end
