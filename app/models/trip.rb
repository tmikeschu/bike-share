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

  validates_uniqueness_of :bike_id, scope: [:start_time]

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
    starts = Trip.joins(:start_station)
    ids = starts.pluck(:start_station_id)
    ids_hash = ids.each_with_object(Hash.new(0)) { |id,counts| counts[id] += 1 }
    most_common_start_station_id = ids_hash.key(ids_hash.values.max)
    Station.where(id: most_common_start_station_id).pluck(:name)
  end

  def self.station_with_most_rides_as_end_point
    ends = Trip.joins(:end_station)
    ids = ends.pluck(:end_station_id)
    ids_hash = ids.each_with_object(Hash.new(0)) { |id,counts| counts[id] += 1 }
    most_common_end_station_id = ids_hash.key(ids_hash.values.min)
    Station.where(id: most_common_end_station_id).pluck(:name)
  end

  def self.most_ridden_bike_and_ride_count
    Trip.group(:bike_id).count("id").max_by{|bike, count| count }
  end

  def self.least_ridden_bike_and_ride_count
    Trip.group(:bike_id).count("id").min_by{|bike, count| count }
  end

  def self.subscription_breakdown
    Trip.group(:subscription_type_id).count("id").values
  end

  def self.subscriber_breakdown
    Trip.subscription_breakdown[0]
  end

  def self.subscriber_percentage
    (Trip.subscriber_breakdown / Trip.all.count) * 100
  end

  def self.customer_breakdown
    Trip.subscription_breakdown[1]
  end

  def self.customer_percentage
    (Trip.customer_breakdown / Trip.all.count) * 100
  end

  def self.date_with_highest_number_trips_total
    Trip.group(:start_date).count("id").max_by{|date, count| count }
  end

  def self.date_with_lowest_number_trips_total
    Trip.group(:start_date).count("id").min_by{|date, count| count }
  end

  def self.monthly_ride_breakdown(year_array, month_array)
    year_array.each do |year|
      trips_by_year[year] = Trip.where("extract(year from start_date) = ?", year)
      trips_by_year
    end

    trips_by_year.each_pair do |year,trips_for_each_year|
      monthly_rides[year] = trips_for_each_year.group("extract(month from start_date)").count("id")
      monthly_rides
    end
  end




end
