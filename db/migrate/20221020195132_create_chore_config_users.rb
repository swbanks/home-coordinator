class CreateChoreConfigUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :chore_config_users do |t|
      t.references :user
      t.references :chore_config

      t.timestamps
    end
  end
end
