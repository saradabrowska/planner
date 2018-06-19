class Task < ApplicationRecord
	belongs_to :task_category, optional: true
	belongs_to :user

  validates :name, presence: true, length: { maximum: 50 }
  validates :start_time, presence: true
  validates :description, length: { maximum: 1000 }


  scope :completed, -> { where(completed: true) }
  scope :to_do, -> { where(completed: false) }

  scope :from_last_month , -> { where(start_time: 1.month.ago.beginning_of_month..1.month.ago.end_of_month) }
end
