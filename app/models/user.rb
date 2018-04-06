class User < ApplicationRecord
  MIN_PASSWORD_LEN = 6
  attr_accessor :remember_token, :activation_token, :reset_token
  before_create :create_activation_digest
  name_validator :name
  email_validator :email
  phone_number_validator :phone_number
  has_secure_password
  validates :password, presence: true, length: { minimum: MIN_PASSWORD_LEN }, allow_nil: true
  MAX_LOGIN_ATTEMPTS = 5
  
  def self.all_advisors
      @advisors = Array.new
      self.where('admin=?',true).each do |advisor|
        @advisors.push([advisor.name,"#{advisor.name}|#{advisor.email}"])
      end 
      return @advisors
  end
  
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
  
  def User.valid_password? password
    !password.blank? && password.length >= MIN_PASSWORD_LEN
  end
  
  # Create a user
  def User.create_user(user_params)
    # create default password from email address if none was provided
    if (password_defaulted = (user_params[:password].blank?))
      return {user: nil, message: "Email is not a valid default password"} if !valid_password?(user_params[:email])
      user_params[:password] = user_params[:email]
      user_params[:password_confirmation] = user_params[:email]
    end
    user = User.create(user_params)
    if !user.errors.any?
      user.set_force_password_reset(password_defaulted) #force user to change default password on first login
      status = user.send_email(:account_activation)
      if status.nil?
        {user: user, message: nil, password_defaulted: password_defaulted}
      else
        user.destroy
        {user: user, message: "Unable to send account activation email to #{user.email}"}
      end
    else
      {user: user, message: user.errors.full_messages}
    end
  end
  
  def login_attempts_remaining
    MAX_LOGIN_ATTEMPTS - consecutive_failed_login_attempts
  end
  
  def failed_login_attempt
    self.consecutive_failed_login_attempts += 1
    update_attribute(:consecutive_failed_login_attempts,consecutive_failed_login_attempts)
  end
  
  def successful_login
    self.consecutive_failed_login_attempts = 0
    update_attribute(:consecutive_failed_login_attempts,consecutive_failed_login_attempts)
  end
  
  def set_disabled state
    self.disabled = state
    update_attribute(:disabled,disabled)
  end
    
  # Remembers a user in the database for use in persistent sessions.
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
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    $reset_token = reset_token # to support cucumber reset password tests
    update_columns(reset_digest:  User.digest(reset_token), reset_sent_at:  Time.zone.now)
  end
  
  def forget_reset_digest
    update_columns(reset_digest:  nil, reset_sent_at:  nil)
  end

  def set_force_password_reset state
    $reset_token = id if state # to support cucumber reset password tests
    self.force_password_reset = state
    update_attribute(:force_password_reset, force_password_reset)
  end

  # Sends specified email.
  def send_email(email_type)
    begin
      UserMailer.send("#{email_type}",self).deliver_now
      nil
    rescue StandardError => e
      if e.message.nil?
        "Unknown error" 
      else
        e.message
      end
    end
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  # Returns true if role is administrator
  def administrator?
    admin?
  end
  
  # Returns true if role is mentor
  def mentor?
    !admin?
  end

private

  # Creates and assigns the activation token and digest.
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
    $activation_token = activation_token #to support cucumber activation tests
  end
end
