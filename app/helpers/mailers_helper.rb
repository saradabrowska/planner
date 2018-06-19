module MailersHelper
  def task_categories(tasks)
  	tasks.map(&:task_category).uniq
  end
end