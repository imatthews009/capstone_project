class Event < ApplicationRecord
    has_many :user_events
    has_many :users, through: :user_events, source: :user
    has_many :comments
    belongs_to :sport
    belongs_to :user 
end
