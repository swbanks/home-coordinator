# == Schema Information
#
# Table name: chore_config_users
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  chore_config_id :bigint
#  user_id         :bigint
#
# Indexes
#
#  index_chore_config_users_on_chore_config_id  (chore_config_id)
#  index_chore_config_users_on_user_id          (user_id)
#
class ChoreConfigUser < ApplicationRecord
  belongs_to :user
  belongs_to :chore_config
end
