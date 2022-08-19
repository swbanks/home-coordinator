class AddDefaultsForChoresCheckedColumns < ActiveRecord::Migration[7.0]
  def up
    change_column :chore_calendar, :checked, :boolean, :default => false
    change_column :chore_calendar, :user_completed, :boolean, :default => false

    ChoreCalendar.update_all(:checked => false, :user_completed => false)
  end

  def down
    change_column_default(:chore_calendar, :checked, from: false, to: nil)
    change_column_default(:chore_calendar, :user_completed, from: false, to: nil)
  end
end
