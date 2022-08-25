# == Schema Information
#
# Table name: chore_calendar
#
#  id             :bigint           not null, primary key
#  checked        :boolean          default(FALSE)
#  chore_date     :date
#  user_completed :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  chore_id       :bigint
#  user_id        :bigint
#
# Indexes
#
#  index_chore_calendar_on_chore_id  (chore_id)
#  index_chore_calendar_on_user_id   (user_id)
#
class ChoreCalendar < ApplicationRecord
    self.table_name = "chore_calendar"

    belongs_to :user
    belongs_to :chore
end
