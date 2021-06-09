class CreateCandidates < ActiveRecord::Migration[6.1]
  def change
    create_table :candidates do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.string :angelist
      t.string :linkedin
      t.integer :position_id

      t.timestamps
    end
    add_foreign_key :candidates, :positions
  end
end
