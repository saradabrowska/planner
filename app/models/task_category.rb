class TaskCategory < ApplicationRecord
  has_many :tasks
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :color, presence: true
  validates_format_of :color, with: /\H/

  before_destroy :set_associated_tasks_category_to_nil

  def set_associated_tasks_category_to_nil
  	Task.where(task_category: self).update_all(task_category_id: nil)
  end
end
