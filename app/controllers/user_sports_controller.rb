class UserSportsController < ApplicationController
    def new
        @usersport = UserSport.new
    end

    def create
    end
end
