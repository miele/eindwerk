class ConvertController < ApplicationController


respond_to :html, :json

def index
@tracks = Track.all
respond_with(@tracks)
end

end
