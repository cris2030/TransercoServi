class Cymsa < ApplicationRecord
  validates :gps_id, presence: true, uniqueness: true
end
