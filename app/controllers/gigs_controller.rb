require 'GCal4Ruby'
class GigsController < ApplicationController
include GCal4Ruby

layout 'html5'
respond_to :html, :json, :mobile

  def index
   	@footer_tweets = Tweet.order("tweets.created DESC").limit(3)
 	@footer_subjects = Subject.order("subjects.id DESC").limit(3)
  	@page_title = 'Skarminkels Gigs'
  	@googles = Google.order("googles.id DESC")
  
  respond_to do |format|
	format.html  { render :layout => 'html5' }
	format.mobile  { render :layout => 'mobile' }
  end
  
  end
  
  def show
  	@footer_tweets = Tweet.order("tweets.created DESC").limit(3)
 	@footer_subjects = Subject.order("subjects.id DESC").limit(3)
  	@page_title = 'Skarminkels Gigs'
  	@json = Google.find(params[:id]).to_gmaps4rails
  	@data = Google.find(params[:id])
  	
  	respond_to do |format|
	format.html  { render :layout => 'html5' }
  end
  	
  end
  
    def showmobile
  	@page_title = 'Skarminkels Gigs'
  	@json = Google.find(params[:id])
  	
  	respond_to do |format|
	format.mobile  { render :layout => false }
  end
  	
  end
  
  def map
  respond_to do |format|
	format.mobile  { render :layout => 'mobile' }
  end

  end
  
  def feed
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
