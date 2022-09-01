module ChoreCalendarService
  def self.get_daily_chores_for_user(user_name, date)
    user = User.find_by(name: user_name)
    ChoreCalendar.includes(:chore).where(user_id: user&.id, chore_date: date)
  end
end