class CreateInterviews < ActiveRecord::Migration[6.1]
  def change
    create_table :interviews do |t|
      t.integer :candidate_id
      t.integer :recruiter_id
      t.string :interview_date
      t.boolean :closed, :default => false
      t.integer :score_id

      t.timestamps
    end
    add_foreign_key :interviews, :candidates
    add_foreign_key :interviews, :recruiters
    add_foreign_key :interviews, :scores
  end
end
