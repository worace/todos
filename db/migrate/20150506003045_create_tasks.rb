class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :list, index: true, foreign_key: true
      t.string :status, default: "incomplete"
      t.string :description
      t.datetime :due_date

      t.timestamps null: false
    end
  end
end
