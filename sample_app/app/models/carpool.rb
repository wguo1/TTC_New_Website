class Carpool < ApplicationRecord
	belongs_to :trip
	validates_uniqueness_of :user_id, :scope => :trip_id
end
