class CreateSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :skills do |t|
      t.string :name
      t.reference :skillable, polymorphic: true

      t.timestamps
    end
  end
end
