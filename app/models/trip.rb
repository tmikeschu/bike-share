class Trip < ActiveRecord::Base

  validates :duration,
            :start_date,
            :start_station_id,
            :end_date,
            :end_station_id,
            :bike_id,
            :subscription_type_id,
            :user_zip_code,
            presence: true

  #need to specify that foreign_key is start_station_id
  belongs_to :station
  belongs_to :subscription_type

  #need to set_primary_key = date
  #need to set_foreign_key = start_date
  belongs_to :weather_condition

end
