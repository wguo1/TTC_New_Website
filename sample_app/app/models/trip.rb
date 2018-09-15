class Trip < ApplicationRecord
  belongs_to :user
  has_many :carpools, dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "featured_trip_id",
                                   dependent:   :destroy
  has_many :followers, through: :passive_relationships, source: :follower
 
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 10000 }
  
  def followed?(other_user)
	followers.include?(other_user)
  end
  
  def max_car_capacity()
	max = 0
	carpools.each{ |carpool|
		if max < carpool.capacity
			max = carpool.capacity
		end
	}
	max
  end
end
