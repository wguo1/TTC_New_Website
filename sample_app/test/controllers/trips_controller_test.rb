require 'test_helper'

class TripsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @trip = trips(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Trip.count' do
      post trips_path, params: { trip: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Trip.count' do
      delete trip_path(@trip)
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy for wrong trip" do
    log_in_as(users(:michael))
    trip = trips(:ants)
    assert_no_difference 'Trip.count' do
      delete micropost_path(trip)
    end
    assert_redirected_to root_url
  end
end
