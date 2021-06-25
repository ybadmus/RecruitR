class CreatePositionSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :position_skills do |t|
      t.integer :skill_id
      t.integer :position_id

      t.timestamps
    end
  end
end
