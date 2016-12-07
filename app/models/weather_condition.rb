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
    WeatherCondition.where(mean_visibility_miles: [miles..miles + 3])
  end

  def self.temperature_metrics(degrees)
    range = self.metric_range_with_increments_of(:max_temperature_f, degrees)
    range.reduce({}) do |result, degrees|
      days = self.days_with_high_temp(degrees)
      trips = self.trips_on_days(days).values
      result["#{degrees}"] = self.ride_metrics(trips)
      result
    end
  end

  def self.precipitation_metrics(inches)
    range = self.metric_range_with_increments_of(:precipitation_inches, inches)
    range.reduce({}) do |result, inches|
      days = self.days_with_precip_inches(inches)
      trips = self.trips_on_days(days).values
      result["#{inches}"] = self.ride_metrics(trips)
      result
    end
  end

  def self.wind_metrics(speed)
    range = self.metric_range_with_increments_of(:mean_wind_speed_mph, speed)
    range.reduce({}) do |result, speed|
      days = self.days_with_wind_speed(speed)
      trips = self.trips_on_days(days).values
      result["#{speed}"] = self.ride_metrics(trips)
      result
    end
  end

  def self.visibility_metrics(miles)
    range = self.metric_range_with_increments_of(:mean_visibility_miles, miles)
    range.reduce({}) do |result, miles|
      days = self.days_with_visibility(miles)
      trips = self.trips_on_days(days).values
      result["#{miles}"] = self.ride_metrics(trips)
      result
    end
  end

  def self.master_metrics
    metrics = {}
    degrees, inches, speed, miles   = 10, 0.5, 4, 4
    metrics[:temperature]       = self.temperature_metrics(degrees)
    metrics[:precipitation]  = self.precipitation_metrics(inches)
    metrics[:wind]   = self.wind_metrics(speed)
    metrics[:visibility] = self.visibility_metrics(miles)
    metrics
  end

  def self.average_rides(rides)
    return 0 if rides.count.zero?
    rides.reduce(:+).to_i / rides.count 
  end

  def self.highest_rides(rides)
    rides.sort[-1].to_i
  end

  def self.lowest_rides(rides)
    rides.sort[0].to_i
  end

  def self.ride_metrics(rides)
    metrics = {}
    metrics[:average_rides] = self.average_rides(rides)
    metrics[:lowest_rides] = self.lowest_rides(rides)
    metrics[:highest_rides] = self.highest_rides(rides)
    metrics
  end

  def self.metric_range_with_increments_of(method, incrementer)
    lower = WeatherCondition.minimum(method.to_sym)
    upper = WeatherCondition.maximum(method.to_sym)
    lower = lower / incrementer * incrementer
    upper = upper / incrementer * incrementer
    (lower..upper).step(incrementer).to_a
  end

  def self.weather_on_day_with_highest_rides
    WeatherCondition.joins(:trips).group(:date).order("count_id DESC").count("id").max_by{|key, value| value}
  end

  def self.weather_on_day_with_lowest_rides
    WeatherCondition.joins(:trips).group(:date).order("count_id DESC").count("id").min_by{|key, value| value}
  end

end
