class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    has_many :user_sports
    has_many :sports, through: :user_sports
    has_many :user_events
    # rename to created_events and attended events through user_events
    has_many :attended_events, through: :user_events, source: :event
    has_many :events #attended events
end
