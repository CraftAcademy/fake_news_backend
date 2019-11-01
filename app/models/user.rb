class User < ActiveRecord::Base
  extend Devise::Models

    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable
    include DeviseTokenAuth::Concerns::User

    has_many :articles

  def user?
    self.role == 'user'
  end

  def journalist?
    
    binding.pry
    
    self.role == 'journalist'
  end

  def subscriber?
    self.role == 'subscriber'
  end
end