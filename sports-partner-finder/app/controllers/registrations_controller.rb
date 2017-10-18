class RegistrationsController < Devise::RegistrationsController
    def create
        super

        if resource.save
            params[:sport_ids].each do |sport_id|
                UserSport.create(user_id: current_user.id, sport_id: sport_id)
            end
        end
            # @usersport = UserSport.new()
            # @usersport.user_id = resource.id
            # # @usersport.sport_id = 
            # @usersport.save
        
    end

    private

    def sign_up_params
      params.require(:user).permit(:username, :city, :profile_url, :email, :password, :password_confirmation)
    end

    def account_update_params
      params.require(:user).permit(:username, :city, :profile_url, :email, :password, :password_confirmation, :current_password)
    end

end
