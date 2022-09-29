module ChoreCalendarService
  def self.get_daily_chores_for_user(user_name, date)
    user = User.find_by(name: user_name)
    ChoreCalendar.includes(:chore).where(user_id: user&.id, chore_date: date)
  end

  def self.update_daily_chores(chore_list)
    chore_list.each do |chore|
      chore_calendar = ChoreCalendar.find(chore[:id])
      chore_calendar.update!(user_completed: chore[:user_completed], checked: chore[:checked])
    end
  end
end