namespace :db do
  task :drop_all => :environment do
    ChoreCalendar.destroy_all
    ChoreConfigUser.destroy_all
    ChoreConfig.destroy_all
    Chore.destroy_all
    User.destroy_all
  end

  task :drop_chores_for_current_month => :environment do
    ChoreCalendar.where(chore_date: Time.now.beginning_of_month.to_date..Time.now.end_of_month.to_date).destroy_all
  end
end