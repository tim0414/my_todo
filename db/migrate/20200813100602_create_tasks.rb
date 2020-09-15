class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.text :uid, null: false
      t.text :name, null: false
      t.text :note
      t.integer :status, null: false
      t.datetime :due_date, null: false
      t.integer :user_id, nul: false

      t.timestamps
    end
  end
end
