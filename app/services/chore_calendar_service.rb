module ChoreCalendarService
  def self.get_daily_chores_for_user(user_name, date)
    user_id = User.find_by(name: user_name).id
    ChoreCalendar.includes(:chore).where(user_id: user_id, chore_date: date)
  end
end