class RegistrationsController < Devise::RegistrationsController

    def create
        build_resource(sign_up_params)
            count = 0
            CS.cities(params[:state], :us).each do |city_in_selected_state|
                if params[:user][:city].to_s.downcase == city_in_selected_state.downcase
                    count += 1
                end
            end

            if count > 0
                resource.save
            else
                redirect_to '/users/sign_up',notice: 'city spelled incorrectly' and return
            end
            
            
        resource.save    

            yield resource if block_given?
            if resource.persisted?
              if resource.active_for_authentication?
                set_flash_message! :notice, :signed_up
                sign_up(resource_name, resource)
                respond_with resource, location: after_sign_up_path_for(resource)
              else
                set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
                expire_data_after_sign_in!
                respond_with resource, location: after_inactive_sign_up_path_for(resource)
              end
            else
              clean_up_passwords resource
              set_minimum_password_length
              respond_with resource
            end

        if resource.save

            params[:sport_ids].each do |sport_id|
                UserSport.create(user_id: current_user.id, sport_id: sport_id)
            end

            updated_city = resource.city.split.map(&:capitalize).join(' ')
            resource.update(city: updated_city)
        end 

        if current_user.profile_url == ""  
            current_user.update(profile_url: "https://eliaslealblog.files.wordpress.com/2014/03/user-200.png")
        end     
    end

    def update
        super

        if resource.save
            params[:sport_ids].each do |sport_id|
                UserSport.create(user_id: current_user.id, sport_id: sport_id)
            end
        end       
    end

    private

    def sign_up_params
      params.require(:user).permit(:username, :city, :profile_url, :email, :password, :password_confirmation)
    end

    def account_update_params
      params.require(:user).permit(:username, :city, :profile_url, :email, :password, :password_confirmation, :current_password)
    end

end
