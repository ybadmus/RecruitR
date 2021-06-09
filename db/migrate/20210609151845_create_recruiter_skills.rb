class CreateRecruiterSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :recruiter_skills do |t|
      t.integer :skill_id
      t.integer :recruiter_id

      t.timestamps
    end
  end
end
