class CreatePositionSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :position_skills do |t|
      t.integer :skillId
      t.integer :positionId

      t.timestamps
    end
  end
end
