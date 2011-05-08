class AlbumsController < ApplicationController

layout 'html5' 
# before_filter :authenticate_user!, :except => [:index,:show]
respond_to :html, :xml, :json,:mobile
	def photo
    @albums = Album.all
  end

  # GET /albums
  # GET /albums.xml
  def index
   @footer_tweets = Tweet.order("tweets.created DESC").limit(3)
 @footer_subjects = Subject.order("subjects.id DESC").limit(3)
@page_title = 'Skarminkels Band'
  
   # @albums = Album.all
	@albums = Album.find_by_sql('SELECT ALbums.id,Pictures.id AS foto,Pictures.upload_file_name,Albums.name from Albums
	INNER JOIN Pictures ON Albums.id = Pictures.album_id GROUP BY ALbums.name')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @albums }
      format.mobile  { render :layout => 'mobile'}
    end
  end
 

  # GET /albums/1
  # GET /albums/1.xml
  # TODO 
  def show
  @footer_tweets = Tweet.order("tweets.created DESC").limit(3)
 @footer_subjects = Subject.order("subjects.id DESC").limit(3)
@page_title = 'Skarminkels Band'
    @album = Album.find(params[:id], :include => :pictures)
     respond_to do |format|
format.html  { render :layout => 'backend' }
format.js  { render :layout => 'backend' }
end
    
  end
  
  def detail
  @footer_tweets = Tweet.order("tweets.created DESC").limit(3)
 @footer_subjects = Subject.order("subjects.id DESC").limit(3)
@page_title = 'Skarminkels Band'
   @album = Album.find(params[:id], :include => :pictures)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @album }
      format.mobile  { render :layout => 'mobile'}
    end
  end
  # GET /albums/new
  # GET /albums/new.xml
  def new
    @album = Album.new

    respond_to do |format|
      format.html { render :layout => 'backend' }
      format.xml  { render :xml => @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @album = Album.find(params[:id])
  end

  # POST /albums
  # POST /albums.xml
  def create
    @album = Album.new(params[:album])

    respond_to do |format|
      if @album.save
      
    #token aangemaakt die niet expired om te syncen met Facebook
    
    access_token = '155275974530339|f91649e3004eddb324943b1f-100001712295014|5gVUPH4S7ysAnaz0iRPzNfmTSxo'
  
 	# via graph api de gebruiken authenticaten
    me = FbGraph::User.me(access_token)
  
 	# een nieuwe album wordt aangemaakt op de bijhorende facebookpagina
  album = me.album!(
    :name => params[:album][:name],
    :message => params[:album][:name]
  ) 
  

        format.html { redirect_to(@album, :notice => 'Album was successfully created.') }
        format.xml  { render :xml => @album, :status => :created, :location => @album }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.xml
  def update
    @album = Album.find(params[:id])

    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to(@album, :notice => 'Album was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.xml
  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to(albums_url) }
      format.xml  { head :ok }
    end
  end
end