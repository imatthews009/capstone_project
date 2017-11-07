class UsersController < ApplicationController
    before_action :find_user, only:[:show, :edit, :update, :destroy]
    before_action :authenticate_user!

    def index
        @users = User.all 
        sort_att = params[:sort] 
        sort_city = params['city_name']
        p 'test'
        p params['city_input']
        if sort_att
            sport = Sport.all.find(params[:sort])
            @users = sport.users
        end

        if sort_city
            p 'test'
            p params['city_name']
            @users = @users.where(city: params["city_name"])
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

