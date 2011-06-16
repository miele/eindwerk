class TweetController < ApplicationController
before_filter :authenticate_user!
layout 'backend'

 def post_update
  	# client.statuses.update! :status=> (params[:tweet][:content] + "#fb") 
  	client.statuses.update! :status=> (params[:tweet][:content] + ' #skarminkels') #POST to http://twitter.com/statuses/update.json
  	
  	@data = ConfigKeys.find(1)
    @token = @data.facebook_access_token
    access_token = @token      	
   	me = FbGraph::User.me(access_token)
 	
 	@fanpage = @data.facebook_fan_page	
	page = me.accounts.detect do |p| 
	  p.name == @fanpage 
	end
	
	page.feed!(
    :message => params[:tweet][:content],
    :name => params[:tweet][:content],
    :description => params[:tweet][:content]
  )

  	
  	redirect_to(:action => 'succes')
  end
  
  private
  # def client
#     Grackle::Client.new(:auth=>{
#       :type=>:oauth,
#       :consumer_key=>'Tt6sgV79WiREAFrMwxhkQ',
#       :consumer_secret=>'m6WQbGTf28mKel9us5lSBhf3EHSsPi8e5nPW7PzI',
#       :token=>"214185669-60c97ajt34v48UuCvLaHD5hWUslt5KlBDZgJqR6S",
#       :token_secret=>"2Ud584NYuPK9MKl82NnY6bRYmCDOsfvvsLLbWQNM"
#     })
# 
#   end
  
  def client
  
  @data = ConfigKeys.find(1)
  
   @key = @data.twitter_consumer_key
   @secret = @data.twitter_consumer_secret
   @token = @data.twitter_oauth_token
   @token_secret = @data.twitter_oauth_secret
  
  
    Grackle::Client.new(:auth=>{
      :type=>:oauth,
      :consumer_key=> @key,
      :consumer_secret=> @secret,
      :token=> @token,
      :token_secret=> @token_secret
    })

  end
  
  def succes
	end

end
