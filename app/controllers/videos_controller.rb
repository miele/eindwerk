class VideosController < ApplicationController

layout 'html5'

  def index
  @footer_tweets = Tweet.order("tweets.created DESC").limit(3)
 @footer_subjects = Subject.order("subjects.id DESC").limit(3)
  @page_title = 'Skarminkels Videos'
  @videos = Video.order("videos.id DESC").paginate(:per_page => 4,:page => params[:page])
  
  respond_to do |format|
	format.html  { render :layout => 'html5' }
	format.js  { render :layout => 'html5' }
	format.mobile  { render :layout => 'mobile' }
  end
  
  end
  
  def list
 @videos = Video.paginate(:per_page => 7,:page => params[:page])
 respond_to do |format|
format.html  { render :layout => 'backend' }
format.js  { render :layout => 'backend' }
end
end
  
  def show
  
   @footer_tweets = Tweet.order("tweets.created DESC").limit(3)
 @footer_subjects = Subject.order("subjects.id DESC").limit(3)
  @page_title = 'Skarminkels Videos'
  @video = Video.find(params[:id])
  
  respond_to do |format|
  	format.html 
    format.mobile { render :layout => 'mobile'}
  end
  
  end
  
  def new
 @video = Video.new
  respond_to do |format|
      format.html { render :layout => 'backend' }
    end
end

def create
 @video = Video.new(params[:video])
 if @video.save
 
 # video link automatisch embedden naar facebook fanpage
 
 	@data = ConfigKeys.find(1)
    @token = @data.facebook_access_token
    access_token = @token      	
   	me = FbGraph::User.me(access_token)
 	
 	@fanpage = @data.facebook_fan_page	
	page = me.accounts.detect do |p| 
	  p.name == @fanpage 
	end
	
	page.feed!(
    :message => params[:video][:title],
    :name => params[:video][:title],
    :description => params[:video][:title]
  )
	
		page.link!(
    :link => params[:video][:body],
    :message => params[:video][:title]
  )

 
 	flash[:notice] = "Video has been created succesfully"
 	redirect_to(:action => 'list')
 else
 	render('new')
 end
end

def edit
 @video = Video.find(params[:id])
  respond_to do |format|
	format.html  { render :layout => 'backend' }
	end 
end

def update
	 @video = Video.find(params[:id])
	 if @video.update_attributes(params[:video])
	 flash[:notice] = "Video has been updated succesfully"
 	redirect_to(:action => 'list')
 else
 	render('edit')
 end
end

def delete
  @video = Video.find(params[:id])
  respond_to do |format|
format.html  { render :layout => 'backend' }
end 
end

def destroy
  @video = Video.find(params[:id])
  @video.destroy
  flash[:notice] = "Video has been deleted succesfully"
  redirect_to(:action => 'list')
end

end
