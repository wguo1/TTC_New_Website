require 'test_helper'
require 'time'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user1@example.com", password: "foobar", password_confirmation: "foobar", UID: 114656766, birthdate:Time.parse('1940-09-25'), phone:"301-800-6431",
	permanent_address: "yes", current_address:"yes", emergency_name:"yes", emergency_phone:"301-987-3322", emergency_email:"yes@goo.com")
	@trip = Trip.new(content: "afdfdsfds")
  end

  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end
  
   test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end
  
	test "UID should be present" do
		@user.UID = 0
		assert_not @user.valid?
	end
  
   test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    duplicate_user = @user.dup
	duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
  
  test "associated trips should be destroyed" do
    @user.save
    @user.trips.create!(content: "Lorem ipsum")
    assert_difference 'Trip.count', -1 do
      @user.destroy
    end
  end
  
  test "follow a trip" do
	assert_not @user.following?(@trip)
	@user.follow(@trip)
	@user.save
	@trip.save
	assert @user.following?(@trip)
	assert @trip.followers.include?(@user)
  end
end
