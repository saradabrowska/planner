class Archiver < BaseJob
  def perform
    Task.from_last_month.where(archived: false).destroy_all
  end
end
