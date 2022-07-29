module ChoreSchedulerService
  def self.create_month
    chore_ids = ChoreConfig.where(schedule_type: ChoreConfig.schedule_types[:all_users_all_days]).where(active: true).pluck(:chore_id)
    user_ids = User.all.pluck(:id)
    now = Time.now
    
    chore_ids.each do |chore_id|
      user_ids.each do |user_id|
        (1..now.end_of_month.day).each do |date|
          ChoreCalendar.create(chore_id: chore_id, user_id: user_id, chore_date: Date.new(now.year, now.month, date))
        end
      end
    end
    # print the entire month of chores for each user. Figure out how to do this
  end
end