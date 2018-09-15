class TripsController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :destroy]
  before_action :load_trip,  only: :destroy
  before_action :admin_or_author, only: :destroy
  
  def index
	 @trips = Trip.paginate(page: params[:page])
  end
  
  def show
    @trip = Trip.find(params[:id])
  end
  
  def edit
    @trip = Trip.find(params[:id])
  end
  
  def update
    @trip = Trip.find(params[:id])
	if @trip.update_attribute(:active, params[:active])
	  flash[:success] = "Trip status changed"
	  redirect_to @trip
    elsif @trip.update_attributes(trip_params)
      flash[:success] = "Trip updated"
      redirect_to @trip
    else
      render 'edit'
    end
  end

  def create
    @trip = current_user.trips.build(trip_params)
    if @trip.save
      flash[:success] = "Trip Created!"
      redirect_to root_url
    else
      @feed_items = Trip.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
	@trip.destroy
    flash[:success] = "Trip deleted"
    redirect_to request.referrer || root_url
  end

  private

    def trip_params
      params.require(:trip).permit(:title, :content, :trip_leaders, :location, :startdate, :enddate)
    end
	
	def load_trip
      # renders 404 on production if not found
	  @trip = Trip.find(params[:id])
	end
	
	def admin_or_author
	  redirect_to(root_url) unless admin_user? || author?
	end
	
	def author?
       @trip.user == current_user
    end
	
	# Confirms an admin user.
    def admin_user?
      current_user.admin != 0
    end
end
