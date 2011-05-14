class Tweet < ActiveRecord::Base

  MY_APPLICATION_NAME = "grawiiti_live"
  
  """Connect to the Twitter API and pull down the latest tweets"""
  def self.get_latest
    tweets = client.statuses.user_timeline? :screen_name => MY_APPLICATION_NAME # hit the API
    tweets.each do |t|
      created = DateTime.parse(t.created_at)
      # create the tweet if it doesn't already exist
      unless Tweet.exists?(["created=?", created])
        Tweet.create({:content => t.text, :created => created })
       end
    end
    
    
	 
  end
  
  private
  def self.client
    Grackle::Client.new(:auth=>{
      :type=>:oauth,
      :consumer_key=>'Tt6sgV79WiREAFrMwxhkQ',
      :consumer_secret=>'m6WQbGTf28mKel9us5lSBhf3EHSsPi8e5nPW7PzI',
      :token=>"214185669-60c97ajt34v48UuCvLaHD5hWUslt5KlBDZgJqR6S",
      :token_secret=>"2Ud584NYuPK9MKl82NnY6bRYmCDOsfvvsLLbWQNM"
    })

  end
end