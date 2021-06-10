class AddMatchedToCandidates < ActiveRecord::Migration[6.1]
  def change
    add_column :candidates, :matched, :bool
  end
end
