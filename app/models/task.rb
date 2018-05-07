class Task < ApplicationRecord
  scope :completed, -> { where(completed: true) }
  scope :to_do, -> { where(completed: false) }
end
