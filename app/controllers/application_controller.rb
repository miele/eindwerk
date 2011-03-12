
class ApplicationController < ActionController::Base

include Facebooker2::Rails::Controller


helper:all


layout 'backend'



def tester
end

  def index
  end
  
 def ensure_authenticated
 	#if current_facebook_user.nil?
 	#redirect_to :root, :notice => 'Facebook inlog'
 	#else
 	User.find_or_create_by_facebook_id(current_facebook_user.id)
 	current_facebook_user.fetch
 	current_facebook_user.feed_create(Mogli::Event.new(:name => 'Weekend at last!'))

 #end
 end
  
end
