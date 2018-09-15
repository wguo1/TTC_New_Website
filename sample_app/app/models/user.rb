class User < ApplicationRecord
    has_many :trips, dependent: :destroy
	has_one  :car, dependent: :destroy
	attr_accessor :remember_token, :activation_token, :reset_token
    before_create :create_activation_digest
	has_many :active_relationships, class_name:  "Relationship",
                                    foreign_key: "follower_id",
                                    dependent:   :destroy
	has_many :following, through: :active_relationships, source: :featured_trip
	
	validates(:name, :emergency_name, presence: true, length: {maximum: 50})
	validates(:UID, :allow_blank => true, length: {is: 9}, format: {with: /\A[0-9]{9}\z/})
	validates :birthdate, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates(:email, :emergency_email, presence: true, length: {maximum: 255}, 
			  format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false })
	validate :user_email_not_same_as_emer_email
	validate :user_phone_not_same_as_emer_phone
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }
	validates(:phone, :emergency_phone,  format:{with: /\(?[0-9]{3}\)?-?[0-9]{3}-?[0-9]{4}/})
	validates(:permanent_address, :current_address, presence: true)
	
	# Returns the hash digest of the given string.
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end
  
	# Returns a random token.
	def User.new_token
		SecureRandom.urlsafe_base64
	end
	
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end
	
	# Returns true if the given token matches the digest.
	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
    end
	
	# Forgets a user.
	def forget
		update_attribute(:remember_digest, nil)
	end
	
	# Activates an account.
    def activate
		update_attribute(:activated,    true)
		update_attribute(:activated_at, Time.zone.now)
    end

    # Sends activation email.
    def send_activation_email
		UserMailer.account_activation(self).deliver_now
    end
	
	# Sets the password reset attributes.
    def create_reset_digest
		self.reset_token = User.new_token
		update_attribute(:reset_digest,  User.digest(reset_token))
		update_attribute(:reset_sent_at, Time.zone.now)
	end

	# Sends password reset email.
	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end
	
	# Returns true if a password reset has expired.
    def password_reset_expired?
		reset_sent_at < 2.hours.ago
    end
	
	# Defines a proto-feed.
	# See "Following users" for the full implementation.
	def feed
		Trip.where("user_id = ?", id)
	end
	
	def follow(other_trip)
		if other_trip.user_id != self.id
			following << other_trip
		end
	end
	
	def unfollow(other_trip)
		if other_trip.user_id != self.id
			following.delete(other_trip)
		end
	end
	
	def following?(other_trip)
		following.include?(other_trip)
	end
	
	private

		# Converts email to all lower-case.
		def downcase_all_email
			self.email = email.downcase
			self.emergency_email = emergency_email.downcase
		end
		
		def parse_phone
			self.phone = phone.tr('^0-9', '') 
			self.emergency_phone = emergency_phone.tr('^0-9', '')
		end
		
		def user_email_not_same_as_emer_email
			downcase_all_email
			@errors.add(:emergency_email, "can't be same as your email") if self.email == self.emergency_email
		end
		
		def user_phone_not_same_as_emer_phone
			parse_phone
			@errors.add(:emergency_phone, "can't be same as your phone") if self.phone == self.emergency_phone
		end

		# Creates and assigns the activation token and digest.
		def create_activation_digest
			self.activation_token  = User.new_token
			self.activation_digest = User.digest(activation_token)
		end
end
