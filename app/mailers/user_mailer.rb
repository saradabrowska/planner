class UserMailer < ActionMailer::Base
  add_template_helper(MailersHelper)

  default from: 'planownik@planownik.com'
  layout 'mailer'

  def archive_notification(user_id)
    @user = User.find(user_id)
    @tasks = @user.tasks.from_last_month
    @task_categories = @tasks.map(&:task_category).compact.uniq.pluck(:name)

    @last_month = I18n.t('date.month_names')[Date.today.ago(1.month).month].capitalize
    @year = Date.today.ago(1.month).year

    mail to: @user.email, subject: "Archiwizacja zadań: #{@last_month} #{@year}"
  end
end