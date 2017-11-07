class EventsController < ApplicationController
    before_action :find_event, only:[:show, :edit, :update, :destroy]
    before_action :beg_date, only:[:create, :update]
    before_action :end_date, only:[:create, :update]

    def index
        @events = Event.where("beg_time >= ?", Time.now)
        sort_att = params[:sort]
        sort_week_att = params[:week]
        if sort_att
            sport = Sport.all.find(params[:sort])
            @events = sport.events.where("beg_time >= ?", Time.now)
        end

        if sort_week_att
            @events = Event.where("beg_time BETWEEN ? AND ?", DateTime.now, DateTime.now + params[:week].to_i)
        end

        sort_city = params['city_name']
        if sort_city
            p 'test'
            p params['city_name']
            @events = @events.where(city: params["city_name"])
        end

        @hash = Gmaps4rails.build_markers(@events) do |event, marker|
          marker.lat event.latitude
          marker.lng event.longitude
          marker.infowindow event.title
        end
    end

    def new
        @event = Event.new
    end

    def create
        address = params[:address]
        # only allow correctly spelled cities
        coordinates = Geocoder.coordinates(address)
        updated_city = params[:city].split.map(&:capitalize).join(' ')
        count = 0
        CS.cities(params[:state], :us).each do |city_in_selected_state|
            if params[:city].to_s.downcase == city_in_selected_state.downcase
                count += 1
            end
        end
        # only allow correctly spelled cities end
        if count > 0
            new_event = Event.new(
            title: params[:title], 
            description: params[:description], 
            image_url: params[:image_url], 
            beg_time: @beg_date, 
            end_time: @end_date, 
            max_athletes: params[:max_athletes], 
            latitude: coordinates[0], 
            longitude: coordinates[1],
            location: params[:location],
            city: updated_city,
            address: params[:address], 
            sport_id: params[:sport_id], 
            user_id: current_user.id)
        else
            redirect_to '/events/new',notice: 'city spelled incorrectly' and return
        end

        

        if new_event.image_url == ""
            new_event.image_url = "https://www.belfercenter.org/themes/belfer/images/event-default-img-med.png" 
            new_event.save
        end

        if new_event.save
            redirect_to new_event
        else
            render 'new'
        end
    end

    def show
        @hash = Gmaps4rails.build_markers(@event) do |event, marker|
          marker.lat event.latitude
          marker.lng event.longitude
        end
    end

    def join
        @event = Event.find_by(id: params[:id])
        if @event.users.count < @event.max_athletes 
            @userevent = UserEvent.create(event_id: params[:id], user_id: current_user.id)
            redirect_to @event 
        else
            redirect_to '/events/' + params[:id], alert: "Maximum athletes reached or you are already attending"
        end
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
        updated_city = params[:city].split.map(&:capitalize).join(' ')
        @event.update(
            title: params[:title], 
            description: params[:description], 
            image_url: params[:image_url], 
            beg_time: @beg_date, 
            end_time: @end_date, 
            max_athletes: params[:max_athletes], 
            latitude: coordinates[0], 
            longitude: coordinates[1],
            location: params[:location],
            city: updated_city,
            address: params[:address],
            sport_id: params[:sport_id], 
            user_id: current_user.id
            )
        @event.save

        if @event.save
            redirect_to @event
        else
            p @event.errors.full_messages
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

    def beg_date
        @beg_date = params[:beg_date]["beg_time(1i)"]+ '-' + params[:beg_date]["beg_time(2i)"] + '-' + params[:beg_date]["beg_time(3i)"] + ' ' + params[:beg_date]["beg_time(4i)"] + ':' + params[:beg_date]["beg_time(5i)"] + ':00'
    end 

    def end_date
        @end_date = params[:end_date]["end_time(1i)"] + '-' + params[:end_date]["end_time(2i)"] + '-' + params[:end_date]["end_time(3i)"]+ ' ' + params[:end_date]["end_time(4i)"]+ ':' + params[:end_date]["end_time(5i)"]+ ':00'
    end

end
