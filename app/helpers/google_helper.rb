module GoogleHelper

require 'gcal4ruby'
include GCal4Ruby



 def authenticate
    if not session[:username] or not session[:password]
      redirect_to :action => :login and return
    end
    @account = Service.new()
    @account.debug = true
    @account.authenticate(session[:username], session[:password])
  end

end
