class TaskCategory < ApplicationRecord
  has_many :tasks
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :color, presence: true
  validates_format_of :color, with: /\H/
end
