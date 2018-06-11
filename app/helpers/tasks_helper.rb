module TasksHelper
  def start_time
    @task.start_time.present? ? @task.start_time : params['start_date'].to_datetime 
  end
end
