class ArchiveNotificator < BaseJob
  def perform
  	User.all.each { |user| UserMailer.archive_notification(user.id).deliver_now }
  end
end
