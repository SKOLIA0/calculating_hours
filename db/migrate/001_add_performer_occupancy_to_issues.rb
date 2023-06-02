class AddPerformerOccupancyToIssues < ActiveRecord::Migration[6.1]
  def change
    add_column :issues, :performer_occupancy, :float
  end
end
