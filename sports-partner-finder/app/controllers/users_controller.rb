class UsersController < ApplicationController
    before_action :find_user, only:[:show, :edit, :update, :destroy]
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

