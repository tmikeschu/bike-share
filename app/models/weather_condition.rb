class WeatherCondition < ActiveRecord::Base
  self.primary_key = "date"

  validates :date,
            :max_temperature_f,
            :mean_temperature_f,
            :min_temperature_f,
            :mean_humidity,
            :mean_visibility_miles,
            :mean_wind_speed_mph,
            :precipitation_inches,
            :zip_code,
            presence: true

  validates :zip_code, inclusion: { in: [94107]}

  has_many :trips, :foreign_key => :start_date

  def self.trips_on_days(day_range)
    day_range.joins(:trips).group(:date).order("count_id DESC").count("id")
  end

  def self.days_with_high_temp(lower)
    WeatherCondition.where(max_temperature_f: [lower..lower+9])
  end

  def self.days_with_precip_inches(inches)
    WeatherCondition.where(precipitation_inches: [inches..inches + 0.49])
  end

  def self.days_with_wind_speed(speed)
    WeatherCondition.where(mean_wind_speed: [speed..speed + 4])
  end

  def self.average_rides(rides)
    rides.reduce(:+) / rides.count
  end

  def self.highest_rides(rides)
    rides.sort[-1]
  end

  def self.lowest_rides(rides)
    rides.sort[0]
  end

end
