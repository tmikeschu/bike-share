class Station < ActiveRecord::Base

  validates :name,
            :dock_count,
            :city_id,
            :installation_date,
            :lat,
            :long,
            presence: true

  belongs_to :city
  has_many :trips, :foreign_key => :start_station_id

end
