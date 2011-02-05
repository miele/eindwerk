class SectionsController < ApplicationController

def index
	list
	render('list')
end

def list
 @sections = Section.order("sections.name ASC")
end

def show
 @section = Section.find(params[:id])
end

def new
 @section = Section.new
end

def create
 @section = Section.new(params[:section])
 if @section.save
 	flash[:notice] = "Section has been created succesfully"
 	redirect_to(:action => 'list')
 else
 	render('new')
 end
end

def edit
 @section = Section.find(params[:id]) 
end

def update
	 @section = Section.find(params[:id])
	 if @section.update_attributes(params[:section])
	 flash[:notice] = "Section has been updated succesfully"
 	redirect_to(:action => 'show', :id => @section.id)
 else
 	render('edit')
 end
end

def delete
  @section = Section.find(params[:id]) 
end

def destroy
  @section = Section.find(params[:id])
  @section.destroy
  flash[:notice] = "Section has been deleted succesfully"
  redirect_to(:action => 'list')
end


end
