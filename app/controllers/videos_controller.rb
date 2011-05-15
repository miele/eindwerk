class VideosController < ApplicationController

layout 'html5'

  def index
  @footer_tweets = Tweet.order("tweets.created DESC").limit(3)
 @footer_subjects = Subject.order("subjects.id DESC").limit(3)
  @page_title = 'Skarminkels Videos'
  @videos = Video.all
  
  respond_to do |format|
      format.html 
      format.mobile { render :layout => 'mobile'}
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

end
