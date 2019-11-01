class User < ActiveRecord::Base
  extend Devise::Models
  after_initialize :set_default_role, if: :new_record?

    enum role: [:user, :subscriber, :journalist]

    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable
    include DeviseTokenAuth::Concerns::User

  private

  def set_default_role
    self.role ||= :user
  end

  def journalist? 
    self.role == :journalist
  end

  def subscriber?
    self.role == :subscriber
  end
end