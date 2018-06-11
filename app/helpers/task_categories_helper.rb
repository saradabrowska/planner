module TaskCategoriesHelper
  def back_path
  	request.referer.include?("tasks/new?start_date=") ? request.referer : task_categories_path	
  end
end
