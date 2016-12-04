class WeatherCondition < ActiveRecord::Base

  validates :date,
            :max_temp,
            :mean_temp,
            :min_temp,
            :mean_humidity,
            :mean_visibility_miles,
            :mean_wind_speed_mph,
            :precipitation_inches,
            presence: true

  has_many :trips

  #need to set_primary_key = date
end
