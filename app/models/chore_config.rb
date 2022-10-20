# == Schema Information
#
# Table name: chore_config
#
#  id            :bigint           not null, primary key
#  active        :boolean
#  chore_days    :string
#  schedule_type :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  chore_id      :bigint
#
# Indexes
#
#  index_chore_config_on_chore_id  (chore_id)
#
class ChoreConfig < ApplicationRecord
  self.table_name = "chore_config"

  enum schedule_type: {
    all_users_all_days: 0,
    specific_users_every_day: 1,
    specific_users_specific_days: 2,
    all_users_specific_days: 3,
    rotate_users_each_week: 4,
    rotate_users_each_day: 5
  }
end
