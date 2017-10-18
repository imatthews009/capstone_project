class Event < ApplicationRecord
    has_many :user_events
    has_many :users, through: :user_events, source: :user
    belongs_to :sport
    belongs_to :user 
end
