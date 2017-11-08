class CommentsController < ApplicationController
    def create
        event_id = params[:comment][:event_id]
        Comment.create(
            user_id: current_user.id,
            event_id: event_id,
            text: params[:text]
            )
        redirect_to event_path(event_id)
    end
end
