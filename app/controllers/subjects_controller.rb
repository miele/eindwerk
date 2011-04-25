require 'GCal4Ruby'
class SubjectsController < ApplicationController
include GCal4Ruby
layout 'html5'

#before_filter :ensure_authenticated
helper_method :sort_column, :sort_direction

respond_to :html, :xml, :json, :mobile

  
 def events
  
  end


def index
	list
	render('list')
end

def top
 @page_title = 'Skarminkels Home'
 @subjects = Subject.order("subjects.id DESC").limit(4)
 @tweets = Tweet.order("tweets.created DESC").limit(10)
  # @events = Event.order("events.id DESC").limit(2)
 @footer_tweets = Tweet.order("tweets.created DESC").limit(3)
 @footer_subjects = Subject.order("subjects.id DESC").limit(3)
 respond_to do |format|
  format.html
  format.mobile {render :layout => 'mobile'}
end
end

def feed
inlog()
 @calendar = Calendar.find(@account,{:id => 'terrormic@gmail.com'})
 @calendars = []
 @events = @calendar.events
respond_to do |format|
  format.html { render :layout => false }
end

end

def list
@subjects = Subject.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 4,:page => params[:page])
respond_to do |format|
format.html  { render :layout => 'backend' }
format.js  { render :layout => 'backend' }
end

end

def news
@subjects = Subject.order("subjects.id DESC").paginate(:per_page => 4,:page => params[:page])
@page_title = 'Skarminkels News'
@footer_tweets = Tweet.order("tweets.created DESC").limit(2)
@footer_subjects = Subject.order("subjects.id DESC").limit(2)

respond_to do |format|
format.html  { render :layout => 'html5' }
format.js  { render :layout => 'html5' }
format.mobile  { render :layout => 'mobile' }
end
 
end

def show
 @subject = Subject.find(params[:id])
 @page_title = 'Skarminkels News Detail'
 @footer_tweets = Tweet.order("tweets.created DESC").limit(2)
 @footer_subjects = Subject.order("subjects.id DESC").limit(2)
 respond_to do |format|
  format.html
  format.mobile {render :layout => 'mobile'}
end
end

def new
 @subject = Subject.new
 respond_to do |format|
format.html  { render :layout => 'backend' }
end
end

def create
 @subject = Subject.new(params[:subject])
 
 if @subject.save
 	flash[:notice] = "Subject has been created succesfully"
 	redirect_to(:action => 'list')
 else
 	render('new')
 end
end

def edit
 @subject = Subject.find(params[:id])
 respond_to do |format|
format.html  { render :layout => 'backend' }
end
end

def update
	 @subject = Subject.find(params[:id])
	 
	 respond_to do |format|
	 if @subject.update_attributes(params[:subject])
	 flash[:notice] = "Subject has been updated succesfully"
 	 format.html {redirect_to(:action => 'list')} 
      else
        format.html {redirect_to(:action => 'edit')}
      end
    end
end

def delete
  @subject = Subject.find(params[:id])
   respond_to do |format|
format.html  { render :layout => 'backend' }
end
 
end

def destroy
  @subject = Subject.find(params[:id])
  @subject.destroy
  flash[:notice] = "Subject has been deleted succesfully"
  respond_to do |format|
      format.html { redirect_to(:action => "list") }
      format.js   { render :nothing => true }
    end
end

def rotate
    photo   = Subject.find(params[:id])
    degrees = if params[:direction] == 'left' then -90 else 90 end

    #main photo
    image   = Magick::ImageList.new(photo.file)
    image   = image.rotate(degrees)
    image.write(photo.file)

    redirect_to :action => 'list'
end

private

def sort_column
 Subject.column_names.include?(params[:sort]) ?  params[:sort] : "name"
end

def sort_direction
%w[asc,desc].include?(params[:direction]) ? params[:direction] : "asc"
end

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
