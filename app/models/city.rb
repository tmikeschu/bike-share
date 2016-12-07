class City < ActiveRecord::Base

  validates :name,
            presence: true

  validates :name, uniqueness: true

  has_many :stations
  has_many :trips, through: :stations

end
