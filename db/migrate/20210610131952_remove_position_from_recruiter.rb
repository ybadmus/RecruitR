class RemovePositionFromRecruiter < ActiveRecord::Migration[6.1]
  def change
    remove_column :recruiters, :position, :string
  end
end
