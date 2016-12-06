class RemoveTripsCountFromWeatherConditions < ActiveRecord::Migration[5.0]
  def change
    remove_column :weather_conditions, :trips_count
  end
end
