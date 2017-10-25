class EventsController < ApplicationController
    before_action :find_event, only:[:show, :edit,:update, :destroy]

    def index
        @events = Event.all
        sort_att = params[:sort]
        if sort_att
            sport = Sport.all.find(params[:sort])
            @events = sport.events
        end
    end

    def new
        @event = Event.new
    end

    def create
        address = params[:address]
        coordinates = Geocoder.coordinates(address)
        new_event = Event.create(
            title: params[:title], 
            description: params[:description], 
            image_url: params[:image_url], 
            beg_time: params[:beg_time], 
            end_time: params[:end_time], 
            max_athletes: params[:max_athletes], 
            latitude: coordinates[0], 
            longitude: coordinates[1],  
            sport_id: params[:sport_id], 
            user_id: current_user.id)
 

        if new_event.save
            redirect_to new_event
        else
            p new_event.errors.full_messages

            render 'new'
        end
    end

    def show
    end

    def join
        @event = Event.find_by(id: params[:id])
        @userevent = UserEvent.create(event_id: params[:id], user_id: current_user.id)
        redirect_to @event 
        p @event.errors.full_messages
    end

    def leave
        @event = Event.find_by(id: params[:id])
        @userevent = UserEvent.find_by(event_id: params[:id], user_id: current_user.id)
        @userevent.update_attribute(:user_id, nil)
        redirect_to @event 
    end

    def edit
    end 

    def update
        address = params[:address]
        coordinates = Geocoder.coordinates(address)

        @event.update(
            title: params[:title], 
            description: params[:description], 
            image_url: params[:image_url], 
            beg_time: params[:beg_time], 
            end_time: params[:end_time], 
            max_athletes: params[:max_athletes], 
            latitude: coordinates[0], 
            longitude: coordinates[1],
            sport_id: params[:sport_id], 
            user_id: current_user.id
            )
        @event.save

        if @event.save
            redirect_to @event
        else
            render 'edit'
        end
    end

    def destroy
        @event.destroy
        redirect_to events_path
    end

    private


    def find_event
        @event = Event.find_by(id: params[:id])
    end

end
