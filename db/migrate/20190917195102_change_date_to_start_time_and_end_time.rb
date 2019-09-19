class ChangeDateToStartTimeAndEndTime < ActiveRecord::Migration[5.2]
  def change
    rename_column :appointments, :date, :start_time
    add_column :appointments, :end_time, :datetime
  end
end
