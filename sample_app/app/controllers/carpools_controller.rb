class CarpoolsController < ApplicationController
	
	def show
		@carpool = Carpool.find(params[:id])
	end
	
	def create
		trip = Trip.find(params[:carpool][:trip_id])
		@carpool = trip.carpools.build(:user_id => params[:carpool][:user_id], :capacity => params[:carpool][:capacity])
		if @carpool.save
			Relationship.find_by(follower_id: @carpool.user_id, featured_trip_id: trip.id).update_attributes(:driver => true)
			flash[:success] = "Carpool Created!"
			redirect_to trip
		else
			@feed_items = Trip.paginate(page: params[:page])
			render 'static_pages/home'
		end
    end
	
	def update
		@carpool = Carpool.find(params[:id])
		@carpool.update_attribute(:passengers, params[:passengers])
		Relationship.find_by(follower_id: User.find(params[:option]), featured_trip_id: @carpool.trip_id).update(:passenger => true)
		@carpool.save
	end
	
	def destroy
		@carpool = Carpool.find(params[:id])
		Relationship.where(follower_id: trip.carpools.find_by(user_id: user.id).passengers).update_all(:driver => false, :passenger => false)
		Relationship.find_by(follower_id: @carpool.user_id, featured_trip_id: )         .update_attributes(:driver => false)
	end
end
