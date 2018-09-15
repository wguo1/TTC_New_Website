class RelationshipsController < ApplicationController
	before_action :logged_in_user
	
	def create
		trip = Trip.find(params[:featured_trip_id])
		current_user.follow(trip)
		Relationship.find_by(follower_id: current_user.id, featured_trip_id: trip.id).update_attributes(relationship_params)
		redirect_to trip
	end
	
	def destroy
		trip = Relationship.find(params[:id]).featured_trip
		current_user.unfollow(trip)
		redirect_to trip
	end
	
	def update
		relationship = Relationship.find(params[:id])
		if relationship.update_attributes(:accept => params[:accept])
			user = User.find(relationship.follower_id)
			if relationship.accept
				flash[:success] = user.name + " has been added onto your trip"
			else
				trip = Trip.find(relationship.featured_trip_id)
				if relationship.driver
					Relationship.where(follower_id: trip.carpools.find_by(user_id: user.id).passengers).update_all(:driver => false, :passenger => false)
					Carpool.destroy(trip.carpools.where(user_id: user.id).ids)
					relationship.update_attributes(:driver => false)
				elsif relationship.passenger
					trip.carpools.each { |carpool| 
						carpool.passengers.remove(user_id)
					}
					relationship.update_attributes(:passenger => false)
				end
				flash[:success] = user.name + " has been taken off of your trip"
			end
			redirect_to Trip.find(relationship.featured_trip_id)
		elsif relationship.update_attributes(:passenger => params[:passenger])
		else
			render 'edit'
		end
	end
	
	def accept
		relationship = Relationship.find(params[:id])
		relationship.update_attributes(:accept => true)
		flash[:success] = User.find(relationship.follower_id).name + " has been added onto your trip"
		redirect_to Trip.find(relationship.featured_trip_id)
	end
	
	def reject
		relationship = Relationship.find(params[:id])
		relationship.update_attributes(:accept => false)
		flash[:success] = User.find(relationship.follower_id).name + " has been taken off of your trip"
		redirect_to Trip.find(relationship.featured_trip_id)
	end

	private	
	
		def relationship_params
			params.require(:relationship).permit(:comments)
		end
end