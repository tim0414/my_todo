class CreateRoutineTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :routine_tasks do |t|
      t.text :uid, null: false
      t.integer :status, null: false
      t.datetime :due_date, null: false
      t.integer :routine_task_info_id, null: false

      t.timestamps
    end
  end
end
