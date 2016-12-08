require 'pry'

class Trip < ActiveRecord::Base

  validates :duration,
            :start_date,
            :start_station_id,
            :end_date,
            :end_station_id,
            :bike_id,
            :subscription_type_id,
            :user_zip_code,
            :start_time,
            :end_time,
            presence: true

  validates_uniqueness_of :bike_id, scope: [:start_date, :start_time]

  belongs_to :start_station, class_name: 'Station', :foreign_key => :start_station_id
  belongs_to :end_station, class_name: 'Station', :foreign_key => :end_station_id
  belongs_to :subscription_type
  belongs_to :weather_condition, :foreign_key => :start_date

  ### Show Station methods ###
  def self.number_rides_started_at_station(station)
    Trip.where(start_station_id: station).count
  end

  def self.number_rides_ended_at_station(station)
    Trip.where(end_station_id: station).count
  end

  def self.station_with_maximum_rides_as_start_location(station)
    most_frequent_destination_station_id = Trip.where(start_station_id: station).group(:end_station_id).count("id").max_by{|bike, count| count }
    Station.where(id: most_frequent_destination_station_id).pluck(:name)
  end

  def self.station_with_maximum_rides_as_end_location(station)
    most_frequent_origin_station_id = Trip.where(start_station_id: station).group(:start_station_id).count("id").max_by{|bike, count| count }
    Station.where(id: most_frequent_origin_station_id).pluck(:name)
  end

  def self.date_with_highest_number_trips(station)
    Trip.where(start_station_id: station).group(:start_date).count("id").max_by{|date, count| count }
  end

  def self.most_frequent_user_zip_code(station)
    Trip.where(start_station_id: station).group(:user_zip_code).count("id").max_by{|zip_code, count| count }
  end

  def self.most_frequent_bike_id(station)
    Trip.where(start_station_id: station).group(:bike_id).count("id").max_by{|bike, count| count }
  end

  ### Trips Dashboard methods ###
  def self.average_trip_duration
    Trip.average(:duration).to_i/60
  end

  def self.maximum_trip_duration
    Trip.maximum(:duration).to_i/60
  end

  def self.minimum_trip_duration
    Trip.minimum(:duration).to_i/60
  end

  def self.station_with_most_rides_as_start_point
    Trip.group(:start_station).count("id").max_by{|station, count| count }    
  end

  def self.station_with_most_rides_as_end_point
    Trip.group(:end_station).count("id").max_by{|station, count| count }    
  end

  def self.most_ridden_bike_and_ride_count
    Trip.group(:bike_id).count("id").max_by{|bike, count| count }
  end

  def self.least_ridden_bike_and_ride_count
    Trip.group(:bike_id).count("id").min_by{|bike, count| count }
  end

  def self.subscription_breakdown
    Trip.group(:subscription_type_id).count("id")
  end

  def self.subscriber_breakdown
    Trip.subscription_breakdown[1]
  end

  def self.subscriber_percentage
    (Trip.subscriber_breakdown / Trip.count) * 100
  end

  def self.subscriber_metrics
    subscriber = {}
    subscriber[:count]      = subscriber_breakdown
    subscriber[:percentage] = subscriber_percentage
    subscriber
  end

  def self.customer_breakdown
    Trip.subscription_breakdown[2]
  end

  def self.customer_percentage
    (Trip.customer_breakdown / Trip.count) * 100
  end

  def self.customer_metrics
    customer = {}
    customer[:count]      = customer_breakdown
    customer[:percentage] = customer_percentage
    customer
  end

  def self.subscription_metrics
    subscriptions = {}
    subscriptions[:subscriber] = subscriber_metrics
    subscriptions[:customer] = customer_metrics
    subscriptions
  end

  def self.date_with_highest_number_trips_total
    Trip.group(:start_date).count("id").max_by{|date, count| count }
  end

  def self.date_with_lowest_number_trips_total
    Trip.group(:start_date).count("id").min_by{|date, count| count }
  end


  def self.month_by_month_breakdown_for_year(year)
    trips = Trip.where("extract(year from start_date) = ?", year)
    breakdown = trips.group("DATE_TRUNC('month', start_date)").count
    self.add_total(breakdown)
  end

  def self.add_total(hash)
    hash[:total] = hash.values.reduce(:+)
    hash
  end

  def self.monthly_breakdown_master
    years = (Trip.minimum("extract(year FROM start_date)").round..Trip.maximum("extract(year FROM start_date)").round).to_a
    years.reduce({}) do |result, year|
      result[year] = self.month_by_month_breakdown_for_year(year)
      result
    end
  end



end
