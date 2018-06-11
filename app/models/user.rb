class User < ApplicationRecord
  attr_accessor :data_processing_confirmation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :data_processing_confirmation, acceptance: true
  has_many :tasks
  has_many :task_categories
end
