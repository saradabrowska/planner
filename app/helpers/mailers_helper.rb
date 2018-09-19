module MailersHelper
  def task_categories(tasks)
    tasks.map(&:task_category).uniq
  end

  def month_for_monthly_summary
    I18n.t('date.month_names')[Date.today.ago(1.month).month].capitalize
  end

  def year_for_monthly_summary
    Date.today.ago(1.month).year
  end

  def archive_date
    (Date.today.beginning_of_month + 7.days).strftime('%d.%m.%Y')
  end
end
