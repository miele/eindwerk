class BandsController < ApplicationController

layout 'html5'

helper_method :sort_column, :sort_direction

respond_to :html, :json, :xml

def index
	list
	render('list')
end

def list
 @bands = Band.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5,:page => params[:page])
 respond_to do |format|
format.html  { render :layout => 'backend' }
format.js  { render :layout => 'backend' }
end
end

def show
 @band = Band.find(params[:id])
end

def new
 @band = Band.new
  respond_to do |format|
      format.html { render :layout => 'backend' }
    end
end

def create
 @band = Band.new(params[:band])
 if @band.save
 	flash[:notice] = "Band has been created succesfully"
 	redirect_to(:action => 'list')
 else
 	render('new')
 end
end

def edit
 @band = Band.find(params[:id])
  respond_to do |format|
format.html  { render :layout => 'backend' }
end 
end

def update
	 @band = Band.find(params[:id])
	 if @band.update_attributes(params[:band])
	 flash[:notice] = "Band has been updated succesfully"
 	redirect_to(:action => 'list')
 else
 	render('edit')
 end
end

def delete
  @band = Band.find(params[:id])
  respond_to do |format|
format.html  { render :layout => 'backend' }
end 
end

def destroy
  @band = Band.find(params[:id])
  @band.destroy
  flash[:notice] = "Band has been deleted succesfully"
  redirect_to(:action => 'list')
end

private

def sort_column
 Subject.column_names.include?(params[:sort]) ?  params[:sort] : "name"
end

def sort_direction
%w[asc,desc].include?(params[:direction]) ? params[:direction] : "asc"
end



end
