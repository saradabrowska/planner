class ArchiveNotificator < BaseJob
  def perform
    User.all.each do |user|
      UserMailer.archive_notification(user.id).deliver_now
    end
  end
end
