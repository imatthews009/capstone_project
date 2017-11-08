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

    has_many :messages
    has_many :comments
    has_many :subscriptions
    has_many :chats, through: :subscriptions
    def existing_chats_users
        existing_chat_users = []
        self.chats.each do |chat|
        existing_chat_users.concat(chat.subscriptions.where.not(user_id: self.id).map {|subscription| subscription.user})
        end
        existing_chat_users.uniq
    end
end
