module ChoreSchedulerService
  SUNDAY = 0
  MONDAY = 1

  class ChoreMonthAlreadyCreatedError < StandardError; end

  def self.add_user_chore(username, chore_name, frequency)
    user = User.find_by(name: username)
    chore = Chore.find_by(name: chore_name)
    return unless chore.present? && user.present?

    date_range_from_frequency(frequency).each do |date|
      chore_date = Date.new(Time.now.year, Time.now.month, date)
      ChoreCalendar.create!(chore_id: chore.id, user_id: user.id, chore_date: chore_date)
    end
  end

  def self.date_range_from_frequency(frequency)
    now = Time.now
    today = now.day

    return (today..today) if frequency == "daily"
    return (today..now.end_of_week.day) if frequency == "weekly"
    (today..now.end_of_month.day)
  end

  def self.create_month
    ChoreCalendar.where(chore_date: Time.now.beginning_of_month..Time.now.end_of_month).first.present? && raise(ChoreMonthAlreadyCreatedError)

    @user_ids = User.all.pluck(:id)
    all_users_all_days
    all_users_specific_days
    specific_users_every_day

    rotate_users_each_week
    rotate_users_each_day
    # print the entire month of chores for each user. Figure out how to do this
    # only rotate through each day of month once, if that is the best option
  end

  def self.rotate_users_each_day
    chore_ids = ChoreConfig.where(schedule_type: ChoreConfig.schedule_types[:rotate_users_each_day]).where(active: true).pluck(:chore_id)
    now = Time.now

    chore_ids.each do |chore_id|
      @last_user_index = get_last_user_index(chore_id) || 0
      move_user_index
      ChoreCalendar.create(chore_id: chore_id, user_id: @user_ids[@last_user_index], chore_date: Date.new(now.year, now.month, 1))
    end
  end

  def self.all_users_specific_days
    chore_info = ChoreConfig.where(schedule_type: ChoreConfig.schedule_types[:all_users_specific_days]).where(active: true).pluck(:chore_id, :chore_days)
    now = Time.now

    chore_info.each do |chore_id, chore_days|
      @user_ids.each do |user_id|
        (1..now.end_of_month.day).each do |date|
          chore_date = Date.new(now.year, now.month, date)
          ChoreCalendar.create(chore_id: chore_id, user_id: user_id, chore_date: chore_date) if chore_days.include? chore_date.wday.to_s
        end
      end
    end
  end

  def self.specific_users_every_day
    chore_info = ChoreConfig.where(schedule_type: ChoreConfig.schedule_types[:specific_users_every_day]).where(active: true).pluck(:id, :chore_id)
    now = Time.now

    chore_info.each do |chore_config_id, chore_id|
      (1..now.end_of_month.day).each do |date|
        #find users and schedule it
        chore_date = Date.new(now.year, now.month, date)
        user_ids = ChoreConfigUser.where(chore_config_id: chore_config_id).pluck(:user_id)
        user_ids.each do |user_id|
          ChoreCalendar.create(chore_id: chore_id, user_id: user_id, chore_date: chore_date)
        end
      end
    end
  end

  def self.all_users_all_days
    chore_ids = ChoreConfig.where(schedule_type: ChoreConfig.schedule_types[:all_users_all_days]).where(active: true).pluck(:chore_id)
    now = Time.now
    
    chore_ids.each do |chore_id|
      @user_ids.each do |user_id|
        (1..now.end_of_month.day).each do |date|
          ChoreCalendar.create(chore_id: chore_id, user_id: user_id, chore_date: Date.new(now.year, now.month, date))
        end
      end
    end
  end

  def self.rotate_users_each_week
    chore_info = ChoreConfig.where(schedule_type: ChoreConfig.schedule_types[:rotate_users_each_week]).where(active: true).pluck(:id, :chore_id)
    now = Time.now

    chore_info.each do |chore_config_id, chore_id|
      valid_user_ids = ChoreConfigUser.where(chore_config_id: chore_config_id).pluck(:user_id)
      @last_user_index = get_last_user_index(chore_id) || 0

      (1..now.end_of_month.day).each do |date|
        chore_date = Date.new(now.year, now.month, date)
        move_user_index(valid_user_ids) if beginning_of_new_week?(chore_date)

        ChoreCalendar.create(chore_id: chore_id, user_id: @user_ids[@last_user_index], chore_date: chore_date)
      end
    end
  end

  def self.move_user_index(valid_user_ids = nil)
    valid = false
    loop do
      @last_user_index = (@last_user_index == @user_ids.length - 1) ? 0 : @last_user_index + 1
      break if valid_user_ids.blank? || valid_user_ids.include?(@user_ids[@last_user_index])
    end
  end

  def self.beginning_of_new_week?(date)
    date.wday == MONDAY
  end

  def self.get_last_user_index(chore_id)
    user_id = ChoreCalendar.where(chore_id: chore_id, chore_date: Time.now.last_month.end_of_month.to_date).pluck(:user_id).first
    @user_ids.index(user_id)
  end
end