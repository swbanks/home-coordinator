class AddDaysListForChoreConfigAndRemoveAllUsersFlag < ActiveRecord::Migration[7.0]
  def change
    remove_column :chore_config, :all_users
    add_column :chore_config, :chore_days, :string
  end
end
