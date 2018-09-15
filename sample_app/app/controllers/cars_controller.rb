class CarsController < ApplicationController
	def create
		@car = current_user.cars.build(car_params)
		if @car.save
		  flash[:success] = "Car Added!"
		  redirect_to root_url
		else
		  @feed_items = Trip.paginate(page: params[:page])
		  render 'static_pages/home'
		end
	end
	
	def car_params
      params.require(:car).permit(:make, :model, :year, :capacity, :license, :state, :color)
    end
end