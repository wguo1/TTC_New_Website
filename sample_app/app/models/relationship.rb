class Relationship < ApplicationRecord
	belongs_to :follower, class_name: "User"
    belongs_to :featured_trip, class_name: "Trip"
	validates :follower_id, presence: true
    validates :featured_trip_id, presence: true
end
