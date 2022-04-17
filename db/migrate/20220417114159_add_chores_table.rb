class AddChoresTable < ActiveRecord::Migration[6.1]
  def change
    create_table :chores do |t|
      t.string :name
      t.timestamps
    end
  end
end
