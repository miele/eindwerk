class Google < ActiveRecord::Base
require 'GCal4Ruby'
include GCal4Ruby


acts_as_gmappable


def gmaps4rails_address
   where
end

def gmaps4rails_marker_picture
  {
  "picture" => "/images/gmap.png",
  "width" => "32",
  "height" => "32"
  }
end    

def sync
 
  @account = Service.new()
    @account.debug = true
    @account.authenticate('terrormic@gmail.com','bogaert')
    @account.check_public = false
    @calendars = @account.calendars
    #GData4Ruby::Request.new(:get, "http://localhost:3000/", nil, nil, {"max_results" => "100"})
    @events = @account.events
    #@events = Event.find(@account, "", {'start-min' => Time.parse("03/01/2011").utc.xmlschema, 'start-max' => Time.parse("06/06/2011").utc.xmlschema})
    @account.check_public = true
 
 
 @calendar = Calendar.find(@account,{:id => 'terrormic@gmail.com'})
 @calendars = []
 @events = @calendar.events
 	@events.each do |event|
 	
 	 start_time = DateTime.parse(event.start_time)
 	 end_time = DateTime.parse(event.end_time)
 	 title = event.title
 	 where = event.where
 	 
 	 unless Google.exists?(["start_time=?", start_time])
        Google.create({:start_time => start_time, :end_time => end_time, :title => title, :where => where })
	 end				
 	end
end

def sync
inlog()
 @calendar = Calendar.find(@account,{:id => 'terrormic@gmail.com'})
 @calendars = []
 @events = @calendar.events
 
 @events.each do |event|
 	
 	 start_time = event.start_time.strftime("%Y-%m-%d %H:%M:%S")
 	 end_time = event.end_time.strftime("%Y-%m-%d %H:%M:%S")
 	 title = event.title
 	 where = event.where
 	 
 	 unless Google.exists?(["start_time=?", start_time])
        Google.create({:start_time => start_time, :end_time => end_time, :title => title, :where => where })
	 end				
 	end

 
respond_to do |format|
  format.html { render :layout => false }
end
end

private

def inlog
	@account = Service.new()
    @account.debug = true
    @account.authenticate('terrormic@gmail.com','bogaert')
    @account.check_public = false
    @calendars = @account.calendars
    #GData4Ruby::Request.new(:get, "http://localhost:3000/", nil, nil, {"max_results" => "100"})
    @events = @account.events
    #@events = Event.find(@account, "", {'start-min' => Time.parse("03/01/2011").utc.xmlschema, 'start-max' => Time.parse("06/06/2011").utc.xmlschema})
    @account.check_public = true
end



end
