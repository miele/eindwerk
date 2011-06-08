class ConvertController < ApplicationController

layout 'mobile'

respond_to :html, :json,:mobile

def index
@news_count = Subject.all.count
@gigs_count = Google.all.count
@pictures_count = Album.all.count
@videos_count = Video.all.count
@tracks_count = Track.all.count
respond_to do |format|
format.html  { render :layout => 'html5' }
format.mobile  { render :layout => 'mobile' }
end

end



end
