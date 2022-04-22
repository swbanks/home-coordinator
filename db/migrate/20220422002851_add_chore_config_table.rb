class AddChoreConfigTable < ActiveRecord::Migration[6.1]
  def change
    create_table :chore_config do |t|
      t.references :chore
      t.integer :schedule_type
      t.boolean :all_users
      t.boolean :active
      t.timestamps
    end
  end
end
