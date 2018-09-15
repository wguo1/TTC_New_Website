class UsersController < ApplicationController
  before_action :logged_in_user, 				 only: [:index, :edit, :update, :destroy, :promote]
  before_action :correct_user,   				 only: :edit
  before_action :trip_leader,    				 only: :destroy
  before_action :correct_user_or_officer,		 only: :update
  
  def index
	 @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new 
	@user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
	  @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
	if @user.update_attribute(:admin, params[:admin])
	  flash[:success] = "User status changed"
	  redirect_to users_url
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  def show
    @user = User.find(params[:id])
    @trips = @user.trips.paginate(page: params[:page])
  end
  
  private
	def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :UID,
                                   :permanent_address, :current_address, :emergency_email,
								   :phone, :emergency_phone, :birthdate, :emergency_name)
    end
	
	# Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
		store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
	
	# Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
	
	# Confirms an trip leader.
    def trip_leader
      redirect_to(root_url) unless current_user.admin != 0
    end
	
	def correct_user_or_officer
		@user = User.find(params[:id])
		redirect_to(root_url) unless current_user.admin > 1 || current_user?(@user)
	end
end
