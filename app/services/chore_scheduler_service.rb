module ChoreSchedulerService
  SUNDAY = 0
  MONDAY = 1

  def self.create_month
    chore_ids = ChoreConfig.where(schedule_type: ChoreConfig.schedule_types[:all_users_all_days]).where(active: true).pluck(:chore_id)
    @user_ids = User.all.pluck(:id)
    now = Time.now
    
    chore_ids.each do |chore_id|
      @user_ids.each do |user_id|
        (1..now.end_of_month.day).each do |date|
          ChoreCalendar.create(chore_id: chore_id, user_id: user_id, chore_date: Date.new(now.year, now.month, date))
        end
      end
    end


    chore_ids = ChoreConfig.where(schedule_type: ChoreConfig.schedule_types[:rotate_users_each_week]).where(active: true).pluck(:chore_id)
    chore_ids.each do |chore_id|

      @last_user_index = get_last_user_index(chore_id)

      (1..now.end_of_month.day).each do |date|
        chore_date = Date.new(now.year, now.month, date)
        move_user_index if beginning_of_new_week?(chore_date)

        ChoreCalendar.create(chore_id: chore_id, user_id: @user_ids[@last_user_index], chore_date: chore_date)
      end
    end

    # print the entire month of chores for each user. Figure out how to do this
  end

  def self.move_user_index
    @last_user_index = (@last_user_index == @user_ids.length - 1) ? 0 : @last_user_index + 1
  end

  def self.beginning_of_new_week?(date)
    date.wday == MONDAY
  end

  def self.get_last_user_index(chore_id)
    user_id = ChoreCalendar.where(chore_id: chore_id, chore_date: Time.now.last_month.end_of_month.to_date).pluck(:user_id).first
    @user_ids.index(user_id)
  end
end