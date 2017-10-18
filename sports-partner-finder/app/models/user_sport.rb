class UserSport < ApplicationRecord
    validates_uniqueness_of :user_id, scope: :sport_id

    belongs_to :user 
    belongs_to :sport
end
