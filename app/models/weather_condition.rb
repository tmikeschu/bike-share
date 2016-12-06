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
    WeatherCondition.where(mean_wind_speed_mph: [speed..speed + 3])
  end

  def self.days_with_visibility(miles)
    WeatherCondition.where(mean_visibility_miles: [speed..speed + 3])
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

  def self.temp_range_with_increments_of(incrementer)
    lower = WeatherCondition.minimum(:max_temperature_f)
    upper = WeatherCondition.maximum(:max_temperature_f)
    lower = lower / 10 * 10
    upper = upper / 10 * 10
    (lower..upper).to_a.find_all{ |num| num % incrementer == 0 }
  end

  def self.weather_on_day_with_highest_rides
    WeatherCondition.joins(:trips).group(:date).order("count_id DESC").count("id").max_by{|key, value| value}
  end

  def self.weather_on_day_with_lowest_rides
    WeatherCondition.joins(:trips).group(:date).order("count_id DESC").count("id").min_by{|key, value| value}
  end

end
