class Task < ApplicationRecord
	belongs_to :task_category, optional: true
	belongs_to :user

  validates :name, presence: true, length: { maximum: 50 }
  validates :start_time, presence: true
  validates :description, length: { maximum: 1000 }


  scope :completed, -> { where(completed: true) }
  scope :to_do, -> { where(completed: false) }
end
