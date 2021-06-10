class CreateRecruiterPositions < ActiveRecord::Migration[6.1]
  def change
    create_table :recruiter_positions do |t|
      t.integer :position_id
      t.integer :recruiter_id

      t.timestamps
    end
  end
end
