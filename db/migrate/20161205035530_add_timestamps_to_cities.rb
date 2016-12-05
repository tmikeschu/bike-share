class AddTimestampsToCities < ActiveRecord::Migration[5.0]
  def change
    add_column(:cities, :created_at, :datetime, null: false)
    add_column(:cities, :updated_at, :datetime, null: false)
  end
end
