class AlbumsController < ApplicationController


helper_method :sort_column, :sort_direction

def index
	@albums = Album.all
end

def list
 @albums = Album.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 4,:page => params[:page])
end

def show
 @album = Album.find(params[:id])
end

def new
 @album = Album.new
end

def create
 @album = Album.new(params[:album])
 if @album.save
 	flash[:notice] = "Album has been created succesfully"
 	redirect_to(:action => 'index')
 else
 	render('new')
 end
end

def edit
 @album = Album.find(params[:id]) 
end

def update
	 @album = Album.find(params[:id])
	 if @album.update_attributes(params[:album])
	 flash[:notice] = "Album has been updated succesfully"
 	redirect_to(:action => 'show', :id => @album.id)
 else
 	render('edit')
 end
end

def delete
  @album = Album.find(params[:id]) 
end

def destroy
  @album = Album.find(params[:id])
  @album.destroy
  flash[:notice] = "Album has been deleted succesfully"
  redirect_to(:action => 'index')
end

private

def sort_column
 Album.column_names.include?(params[:sort]) ?  params[:sort] : "name"
end

def sort_direction
%w[asc,desc].include?(params[:direction]) ? params[:direction] : "asc"
end




end
