class FbController < ApplicationController

	def index
      
  #Instantiate a new application with our app_id so we can get an access token
      my_app = FbGraph::Application.new('117260825001053')
      acc_tok = my_app.get_access_token('cc2691c8b0d25ae6b62816618e14b659')
      
 
 #Instantiate a new page class using the page_id specified 
     @page = FbGraph::Page.new('20419944259', :access_token => acc_tok).fetch
 
 #Grab the events from the page 

     events = @page.events.sort_by{|e| e.start_time}
     
 #Get the events that are upcoming
 	
     @upcoming_events = events.find_all{|e| e.start_time >= Time.now}
 
 #Get the events that have passed
     @past_events = events.find_all{|e| e.start_time < Time.now}.reverse
   end

end
