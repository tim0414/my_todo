class CreateRoutineTaskInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :routine_task_infos do |t|
      t.text :uid, null: false
      t.text :name, null: false
      t.text :note
      t.integer :period, null: false
      t.integer :routine_time, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
