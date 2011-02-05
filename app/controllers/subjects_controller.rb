class SubjectsController < ApplicationController

layout 'html5'

def index
	list
	render('list')
end

def top
 @subjects = Subject.order("subjects.id DESC").limit(2)
 @tweets = Tweet.order("tweets.created DESC").limit(5)
end

def list
 @subjects = Subject.order("subjects.position ASC")
end

def show
 @subject = Subject.find(params[:id])
end

def new
 @subject = Subject.new
end

def create
 @subject = Subject.new(params[:subject])
 if @subject.save
 	flash[:notice] = "Subject has been created succesfully"
 	redirect_to(:action => 'list')
 else
 	render('new')
 end
end

def edit
 @subject = Subject.find(params[:id]) 
end

def update
	 @subject = Subject.find(params[:id])
	 if @subject.update_attributes(params[:subject])
	 flash[:notice] = "Subject has been updated succesfully"
 	redirect_to(:action => 'show', :id => @subject.id)
 else
 	render('edit')
 end
end

def delete
  @subject = Subject.find(params[:id]) 
end

def destroy
  @subject = Subject.find(params[:id])
  @subject.destroy
  flash[:notice] = "Subject has been deleted succesfully"
  redirect_to(:action => 'list')
end

end
