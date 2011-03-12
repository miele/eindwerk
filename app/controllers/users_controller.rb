class UsersController < ApplicationController


layout 'backend'

def index
	list
	render('list')
end

def list
 @users = User.order("users.email DESC")
end


def show
 @user = User.find(params[:id])
end

def new
 @user = User.new
end

def create
 @user = User.new(params[:user])
 if @user.save
 	flash[:notice] = "User has been created succesfully"
 	redirect_to(:action => 'list')
 else
 	render('new')
 end
end

def edit
 @user = User.find(params[:id]) 
end

def update
	 @user = User.find(params[:id])
	 if @user.update_attributes(params[:user])
	 flash[:notice] = "User has been updated succesfully"
 	redirect_to(:action => 'show', :id => @user.id)
 else
 	render('edit')
 end
end

def delete
  @user = User.find(params[:id]) 
end

def destroy
  @user = User.find(params[:id])
  @user.destroy
  flash[:notice] = "User has been deleted succesfully"
  redirect_to(:action => 'list')
end


end
