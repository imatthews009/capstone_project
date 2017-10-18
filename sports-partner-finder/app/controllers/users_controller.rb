class UsersController < ApplicationController
    before_action :authenticate_user!

    def index
        @users = User.all 
        sort_att = params[:sort] 
        if sort_att
            sport = Sport.all.find(params[:sort])
            @users = sport.users
        end
    end

    def show
        @user = User.find_by(id: params[:id])
    end
end

