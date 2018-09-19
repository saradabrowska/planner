module TasksHelper
  def start_time
    if @task.start_time.present?
      @task.start_time
    else
      params['start_date'].to_datetime
    end
  end

  def new_back_path
    if request.referer && request.referer.include?('/day')
      request.referer
    else
      week_path
    end
  end

  def first_day_of_week(week)
    week.first.strftime('%d.%m.%Y')
  end

  def last_day_of_week(week)
    week.last.strftime('%d.%m.%Y')
  end
end
