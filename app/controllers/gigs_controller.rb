class GigsController < ApplicationController

layout 'html5'
respond_to :html, :json, :mobile

  def index
   	@footer_tweets = Tweet.order("tweets.created DESC").limit(3)
 	@footer_subjects = Subject.order("subjects.id DESC").limit(3)
  	@page_title = 'Skarminkels Gigs'
  	@googles = Google.all
  
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
  end

end
