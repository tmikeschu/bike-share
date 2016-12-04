class City < ActiveRecord::Base

  validates :name,
            presence: true

  has_many :stations
  has_many :trips, through: :stations

end
