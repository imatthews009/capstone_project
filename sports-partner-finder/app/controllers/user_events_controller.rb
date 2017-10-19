class UserEventsController < ApplicationController
    def destroy
        @userevent = UserEvent.find_by(event_id: params[:id], user_id: current_user.id)
        @userevent.destroy
        redirect_to '/events/#{params[:id]}'
    end
end
