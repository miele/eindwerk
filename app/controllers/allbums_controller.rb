class AllbumsController < ApplicationController

layout 'backend'

respond_to :html,:js

  def list
 	@albums = Album.all
 	respond_to do |format|
		format.html  { render :layout => 'backend' }
		format.js  { render :layout => 'backend' }
  	end
end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
	
	 flash[:notice] = "Album has been delete succesfully"
 	redirect_to(:controller => 'allbums',:action => 'list')
end


end
