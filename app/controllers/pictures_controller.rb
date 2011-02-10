class PicturesController < ApplicationController
  
 
helper_method :sort_column, :sort_direction

def index
	list
	render('list')
end

def list
 @pictures = Picture.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 4,:page => params[:page])
end

def show
 @picture = Picture.find(params[:id])
end

def new
 @picture = Picture.new
end

def create
 @picture = Picture.new(params[:picture])
 if @picture.save
 	flash[:notice] = "Picture has been created succesfully"
 	redirect_to(:action => 'list')
 else
 	render('new')
 end
end

def edit
 @picture = Picture.find(params[:id]) 
end

def update
	 @picture = Picture.find(params[:id])
	 if @picture.update_attributes(params[:picture])
	 flash[:notice] = "Picture has been updated succesfully"
 	redirect_to(:action => 'show', :id => @picture.id)
 else
 	render('edit')
 end
end

def delete
  @picture = Picture.find(params[:id]) 
end

def destroy
  @picture = Picture.find(params[:id])
  @picture.destroy
  flash[:notice] = "Picture has been deleted succesfully"
  redirect_to(:action => 'list')
end

private

def sort_column
 Picture.column_names.include?(params[:sort]) ?  params[:sort] : "name"
end

def sort_direction
%w[asc,desc].include?(params[:direction]) ? params[:direction] : "asc"
end



end
