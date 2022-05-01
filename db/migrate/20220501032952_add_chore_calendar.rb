class AddChoreCalendar < ActiveRecord::Migration[6.1]
  def change
    create_table :chore_calendar do |t|
      t.references :chore
      t.references :user
      t.date :chore_date
      t.boolean :user_completed
      t.boolean :checked
      t.timestamps
    end
  end
end
