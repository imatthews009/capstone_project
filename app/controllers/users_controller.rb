class UsersController < ApplicationController
    before_action :find_user, only:[:show, :edit, :update, :destroy]
    before_action :authenticate_user!

    def index
        @users = User.all
        @users_sort = User.all 
        sort_att = params[:sport] 
        @unique_users = @users.to_a.uniq{ |o| o.city}

        if sort_att
            sport = Sport.find(params[:sport])
            @users_sort = sport.users
            @users_sort = @users_sort.where(city: params["city_name"])
            
        end

        @cities = []
        @users.each do |user|
            @cities << user.city
        end
    end

    def show
        
    end

    def edit

    end

    def update
    end

    def destroy
    end

    private

    def find_user
        @user = User.find_by(id: params[:id])
    end

end

