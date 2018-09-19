module TaskCategoriesHelper
  def back_path
    if request.referer && request.referer.include?('tasks/new?start_date=')
      request.referer
    else
      task_categories_path
    end
  end
end
