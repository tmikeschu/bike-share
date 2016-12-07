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
    start = Trip.where(start_station_id: station)
    stations = start.pluck(:end_station_id)
    end_stations_hash = stations.each_with_object(Hash.new(0)) { |station,counts| counts[station] += 1 }
    most_frequent_destination_station_id = end_stations_hash.key(end_stations_hash.values.max)
    Station.where(id: most_frequent_destination_station_id).pluck(:name)
  end

  def self.station_with_maximum_rides_as_end_location(station)
    start = Trip.where(end_station_id: station)
    stations = start.pluck(:start_station_id)
    start_stations_hash = stations.each_with_object(Hash.new(0)) { |station,counts| counts[station] += 1 }
    most_frequent_origin_station_id = start_stations_hash.key(start_stations_hash.values.max)
    Station.where(id: most_frequent_origin_station_id).pluck(:name)
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





end
