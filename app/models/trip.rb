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

  belongs_to :station, :foreign_key => :id
  belongs_to :subscription_type
  belongs_to :weather_condition, :foreign_key => :start_date

end
