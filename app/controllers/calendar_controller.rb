class CalendarController < ApplicationController

before_filter :authenticate_user!, :except => [:index,:show]

layout 'html5'
  
  	def index
    	@month = (params[:month] || (Time.zone || Time).now.month).to_i
    	@year = (params[:year] || (Time.zone || Time).now.year).to_i
    	@shown_month = Date.civil(@year, @month)
    	@event_strips = Event.event_strips_for_month(@shown_month)
  	end
  
  	def list
	 	@events = Event.order("events.name ASC")
  	end

	def show
 		@event = Event.find(params[:id])
 	end

	def new
 		@event = Event.new
	end

	def create
		 @event = Event.new(params[:event])
 	if @event.save
 		flash[:notice] = "Event has been created succesfully"
 		redirect_to(:action => 'list')
 	else
 	render('new')
 	end
		end

	def edit
 		@event = Event.find(params[:id]) 
	end

	def update
	 	@event = Event.find(params[:id])
	 if @event.update_attributes(params[:event])
	 	flash[:notice] = "Event has been updated succesfully"
 		redirect_to(:action => 'show', :id => @event.id)
 	else
 		render('edit')
 	end
	end

	def delete
  		@event = Event.find(params[:id]) 
	end

	def destroy
 		 @event = Event.find(params[:id])
  		 @event.destroy
  		 flash[:notice] = "Event has been deleted succesfully"
  		 redirect_to(:action => 'list')
	end

  
end
