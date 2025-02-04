class AllowNullFromStatusInStatusChanges < ActiveRecord::Migration[8.0]
  def change
    change_column_null :status_changes, :from_status, true
  end
end
