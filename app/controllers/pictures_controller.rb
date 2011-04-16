class PicturesController < ApplicationController
  # GET /pictures
  # GET /pictures.xml
  def index
    @pictures = Picture.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pictures }
    end
  end

  # GET /pictures/1
  # GET /pictures/1.xml
  def show
  @footer_tweets = Tweet.order("tweets.created DESC").limit(3)
 @footer_subjects = Subject.order("subjects.id DESC").limit(3)
@page_title = 'Skarminkels Band'
    @picture = Picture.find(params[:id], :include => :album)
    @total_pictures = Picture.find(:all, :conditions => { :album_id => @picture.album.id})
  end

  # GET /pictures/new
  # GET /pictures/new.xml
  def new
    @picture = Picture.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @picture }
    end
  end

  # GET /pictures/1/edit
  def edit
    @picture = Picture.find(params[:id])
  end

  # POST /pictures
  # POST /pictures.xml
  def create
  
      newparams = coerce(params)
      @picture = Picture.new(newparams[:picture])
      if @picture.save
      
      access_token = '155275974530339|f91649e3004eddb324943b1f-100001712295014|5gVUPH4S7ysAnaz0iRPzNfmTSxo'
      	
   		me = FbGraph::User.me(access_token)
      
       	album = me.albums.first
  		album.photo!(
    	:access_token => access_token,
    	:image => File.new('/Users/michiel_bogaert/Sites/skarminkels/public/system/uploads/' + @picture.id.to_s + '/medium/' + @picture.upload_file_name.to_s), 
    	:message => 'Automatic uploadz'
  		)
      
      
        flash[:notice] = "Successfully created Picture."
        respond_to do |format|
          format.html {redirect_to @picture.album}
          format.json {render :json => { :result => 'success', :picture => pictures_path(@picture) } }
        end
      else
        render :action => 'new'
      end
    end

  # PUT /pictures/1
  # PUT /pictures/1.xml
  def update
    @picture = Picture.find(params[:id])

    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        format.html { redirect_to(@picture, :notice => 'Picture was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.xml
  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to(pictures_url) }
      format.xml  { head :ok }
    end
  end
  
  private 
  def coerce(params)
    if params[:picture].nil? 
      h = Hash.new 
      h[:picture] = Hash.new 
      h[:picture][:album_id] = params[:album_id] 
      h[:picture][:upload] = params[:Filedata] 
      h[:picture][:upload].content_type = MIME::Types.type_for(h[:picture][:upload].original_filename).to_s
      h
    else 
      params
    end 
  end
  
end
