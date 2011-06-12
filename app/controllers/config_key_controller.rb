class ConfigKeyController < ApplicationController

before_filter :authenticate_user!

layout 'backend'

  def index
  @config_key = ConfigKeys.find(1)
  respond_to do |format|
		format.html  { render :layout => 'backend' }
	end
  end
  
  def show
 	@config_key = ConfigKeys.find(params[:id])
  end

  def edit
  @config_key = ConfigKeys.find(params[:id])
 	respond_to do |format|
		format.html  { render :layout => 'backend' }
	end
  end
  
  def update
	 @config_key = ConfigKeys.find(params[:id])
	 
	 respond_to do |format|
	 if @config_key.update_attributes(params[:config_key])
	 flash[:notice] = "Config file met succes aangepast!"
 	 	format.html {redirect_to(:action => 'index')} 
      else
        format.html {redirect_to(:action => 'edit')}
      end
    end
end

end
