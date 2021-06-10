class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.integer :experience
      t.integer :dynamism
      t.integer :interest
      t.integer :enthusiasm
      t.integer :technical_skill
      t.integer :interview_id

      t.timestamps
    end
    add_foreign_key :scores, :interviews
  end
end
