# == Schema Information
#
# Table name: chore_config
#
#  id            :integer          not null, primary key
#  active        :boolean
#  all_users     :boolean
#  schedule_type :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  chore_id      :integer
#
# Indexes
#
#  index_chore_config_on_chore_id  (chore_id)
#
class ChoreConfig < ApplicationRecord
    self.table_name = "chore_config"
end
