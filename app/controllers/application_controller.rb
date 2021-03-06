
class ApplicationController < ActionController::Base

include Facebooker2::Rails::Controller

# rescue_from ActiveRecord::RecordNotFound, :with => :show_errors
# rescue_from ActionController::UnknownAction, :with => :show_errors
# rescue_from Exception, :with => :show_errors
# rescue_from ActiveRecord::RecordNotFound, :with => :show_errors
# rescue_from ActionController::RoutingError, :with => :show_errors
# rescue_from AbstractController::ActionNotFound, :with => :show_errors

before_filter :prepare_for_mobile

respond_to :html, :xml, :json, :mobile

helper:all


layout 'backend'

  def mobile_device?  
    request.user_agent =~ /Mobile|webOS/  
  end
  helper_method :mobile_device?

def tester
end

  def index
  end
  
  def show_errors
 render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
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

  def prepare_for_mobile
  request.format = :mobile if mobile_device?
  end  

  
end
