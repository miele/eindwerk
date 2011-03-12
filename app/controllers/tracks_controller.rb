class TracksController < ApplicationController

layout 'html5'
respond_to :html, :json

helper_method :sort_column, :sort_direction

def index
@tracks = Track.all
respond_with(@tracks)
end

def player
@tracks = Track.order("tracks.id DESC")
end

def lijst
 @tracks = Track.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 4,:page => params[:page])
 respond_to do |format|
format.html  { render :layout => 'backend' }
format.js  { render :layout => 'backend' }
end
end

def show
 @track = Track.find(params[:id])
end

def new
 @track = Track.new
 respond_to do |format|
format.html  { render :layout => 'backend' }
end
end

def create
  @track = Track.new(params[:track])
      if @track.save
        flash[:notice] = 'Track was successfully created.'
        @tracks = Track.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 4,:page => params[:page])
        render :action => "lijst"
      else
        render :action => "new"
      end
    end

def edit
 @track = Track.find(params[:id])
 respond_to do |format|
format.html  { render :layout => 'backend' }
format.js  { render :layout => 'backend' }
end
end

def update
	 @track = Track.find(params[:id])
	 if @track.update_attributes(params[:track])
	 flash[:notice] = "Track has been updated succesfully"
 	redirect_to(:action => 'lijst')
 else
 	render('edit')
 end
end

def delete
  @track = Track.find(params[:id]) 
end

def destroy
  @track = Track.find(params[:id])
  @track.destroy
  flash[:notice] = "Track has been deleted succesfully"
  redirect_to(:action => 'lijst')
end

private

def sort_column
 Track.column_names.include?(params[:sort]) ?  params[:sort] : "name"
end

def sort_direction
%w[asc,desc].include?(params[:direction]) ? params[:direction] : "asc"
end



end
