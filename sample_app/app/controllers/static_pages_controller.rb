class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @trip  = current_user.trips.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
