class Station < ActiveRecord::Base

  validates :name,
            :dock_count,
            :city_id,
            :installation_date,
            :lat,
            :long,
            presence: true

  validates :name, uniqueness: true

  belongs_to :city
  has_many :departure_trips, class_name: 'Trip', :foreign_key => :start_station_id
  has_many :arrival_trips, class_name: 'Trip', :foreign_key => :end_station_id

  def self.total_station_count
    count
  end

  def self.average_bikes_per_station
    average(:dock_count).to_i
  end

  def self.maximum_bikes_per_station
    maximum(:dock_count)
  end

  def self.stations_with_maximum_bikes_available
    where(dock_count:(maximum(:dock_count))).pluck(:name)
  end

  def self.minimum_bikes_per_station
    minimum(:dock_count)
  end

  def self.stations_with_minimum_bikes_available
    where(dock_count:(minimum(:dock_count))).pluck(:name)
  end

  def self.newest_station
    Station.find_by(installation_date: (Station.maximum(:installation_date)))
  end

  def self.oldest_station
    Station.find_by(installation_date: (Station.minimum(:installation_date)))
  end

end
