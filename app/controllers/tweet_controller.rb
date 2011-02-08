class TweetController < ApplicationController

layout 'html5'

 def post_update
  	client.statuses.update! :status=> (params[:tweet][:content] + "#fb") #POST to http://twitter.com/statuses/update.json
  	redirect_to(:action => 'succes')
  end
  
  private
  def client
    Grackle::Client.new(:auth=>{
      :type=>:oauth,
      :consumer_key=>'Tt6sgV79WiREAFrMwxhkQ',
      :consumer_secret=>'m6WQbGTf28mKel9us5lSBhf3EHSsPi8e5nPW7PzI',
      :token=>"214185669-60c97ajt34v48UuCvLaHD5hWUslt5KlBDZgJqR6S",
      :token_secret=>"2Ud584NYuPK9MKl82NnY6bRYmCDOsfvvsLLbWQNM"
    })

  end
  
  def succes
	end

end
