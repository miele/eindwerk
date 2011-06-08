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
 @footer_tweets = Tweet.order("tweets.created DESC").limit(2)
 @footer_subjects = Subject.order("subjects.id DESC").limit(2)
 respond_to do |format|
  format.html
  format.mobile {render :layout => 'mobile'}
end
end

def feed
# automatisch inloggen met de geconfigureerde gegevens

 inlog()
 @dataz = ConfigKeys.find(1)
 @id = @dataz.google_email
 @calendar = Calendar.find(@account,{:id => @id})
 @calendars = []
 @events = @calendar.events
 
 # indien er nieuwe events zijn bijgekomen, download ze anders doe niks
 
 @events.each do |event|
 	
 	 start_time = event.start_time.strftime("%Y-%m-%d %H:%M:%S")
 	 end_time = event.end_time.strftime("%Y-%m-%d %H:%M:%S")
 	 title = event.title
 	 where = event.where
 
 #indien nieuw record, wordt de plaats automatisch omgezet naar longitude/latitude cošrdinaten	 
 	 unless Google.exists?(["start_time=?", start_time])
        Google.create({:start_time => start_time, :end_time => end_time, :title => title, :where => where })
	 end				
 	end

 
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

#nieuws wordt opgesplits met vooruitzicht op mobile
#paginatie kan dan via ajax gerendered worden

def news
@subjects = Subject.order("subjects.id DESC").paginate(:per_page => 6,:page => params[:page])
@page_title = 'News'
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
 
  @data = ConfigKeys.find(1)
     
     @token = @data.facebook_access_token
     access_token = @token
   	 me = FbGraph::User.me(access_token)
    @fanpage = @data.facebook_fan_page
    
	page = me.accounts.detect do |p| 
	  p.name == @fanpage 
	end
	
	@gmail = @data.google_email
 	@gmail_pass = @data.google_email_password
	
	client = Googl.client(@gmail,@gmail_pass)

   url = client.shorten('http://localhost:3000/Subjects/show/' + @subject.id.to_s)
  
	
	page.feed!(
    :message => (params[:subject][:content]).html_safe,
    :picture => File.new('/Users/michiel_bogaert/Sites/skarminkels/public/system/photos/' + @subject.id.to_s + '/thumb/' + 								@subject.photo_file_name.to_s),
    :link => url.short_url,
    :name => params[:subject][:name],
    :description => params[:subject][:name]
  )

 
 
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

 @data = ConfigKeys.find(1)
 @gmail = @data.google_email
 @gmail_pass = @data.google_email_password

	@account = Service.new()
    @account.debug = true
    @account.authenticate(@gmail,@gmail_pass)
    @account.check_public = false
    @calendars = @account.calendars
    #GData4Ruby::Request.new(:get, "http://localhost:3000/", nil, nil, {"max_results" => "100"})
    @events = @account.events
    #@events = Event.find(@account, "", {'start-min' => Time.parse("03/01/2011").utc.xmlschema, 'start-max' => Time.parse("06/06/2011").utc.xmlschema})
    @account.check_public = true
end


end
