class TweetController < ApplicationController

layout 'backend'

 def post_update
  	# client.statuses.update! :status=> (params[:tweet][:content] + "#fb") 
  	client.statuses.update! :status=> (params[:tweet][:content]) #POST to http://twitter.com/statuses/update.json
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
