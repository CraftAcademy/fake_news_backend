# app/models/user.rb
class User < ActiveRecord::Base
  extend Devise::Models
    # Include default devise modules.
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :trackable, :validatable
    include DeviseTokenAuth::Concerns::User
  end