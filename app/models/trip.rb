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
    starts = Trip.where(start_station_id: station)
    stations = starts.pluck(:end_station_id)
    end_stations_hash = stations.each_with_object(Hash.new(0)) { |station,counts| counts[station] += 1 }
    most_frequent_destination_station_id = end_stations_hash.key(end_stations_hash.values.max)
    Station.where(id: most_frequent_destination_station_id).pluck(:name)
  end

  def self.station_with_maximum_rides_as_end_location(station)
    ends = Trip.where(end_station_id: station)
    stations = ends.pluck(:start_station_id)
    start_stations_hash = stations.each_with_object(Hash.new(0)) { |station,counts| counts[station] += 1 }
    most_frequent_origin_station_id = start_stations_hash.key(start_stations_hash.values.max)
    Station.where(id: most_frequent_origin_station_id).pluck(:name)
  end

  def self.date_with_highest_number_trips(station)
    start = Trip.where(start_station_id: station)
    start_dates = start.pluck(:start_date)
    start_dates_hash = start_dates.each_with_object(Hash.new(0)) { |date,counts| counts[date] += 1 }
    most_frequent_start_date = start_dates_hash.key(start_dates_hash.values.max)
  end

  def self.most_frequent_user_zip_code(station)
    start = Trip.where(start_station_id: station)
    zip_codes = start.pluck(:user_zip_code)
    zip_codes_hash = zip_codes.each_with_object(Hash.new(0)) { |zip_code,counts| counts[zip_code] += 1 }
    most_frequent_zip_code = zip_codes_hash.key(zip_codes_hash.values.max)
  end

  def self.most_frequent_bike_id(station)
    start = Trip.where(start_station_id: station)
    bike_ids = start.pluck(:bike_id)
    bike_ids_hash = bike_ids.each_with_object(Hash.new(0)) { |bike_id,counts| counts[bike_id] += 1 }
    most_frequent_bike_id = bike_ids_hash.key(bike_ids_hash.values.max)
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
