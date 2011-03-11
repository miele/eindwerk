class AlbumsController < ApplicationController


before_filter :authenticate_user!, :except => [:index,:show]

  # GET /albums
  # GET /albums.xml
  def index
   # @albums = Album.all
	@albums = Album.find_by_sql('SELECT ALbums.id,Pictures.id AS foto,Pictures.upload_file_name,Albums.name from Albums
	INNER JOIN Pictures ON Albums.id = Pictures.album_id GROUP BY ALbums.name')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @albums }
    end
  end
 

  # GET /albums/1
  # GET /albums/1.xml
  def show
    @album = Album.find(params[:id], :include => :pictures)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @album }
    end
  end

  # GET /albums/new
  # GET /albums/new.xml
  def new
    @album = Album.new

    respond_to do |format|
      format.html # new.html.erb
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
    access_token = '155275974530339|f91649e3004eddb324943b1f-100001712295014|5gVUPH4S7ysAnaz0iRPzNfmTSxo'
    #access_token = '117950878254050|6c20ed3fee3f7e48e87423b6-100001712295014|8UPhFpvVKP_gtlRGmB97--aOPNo'
 
    me = FbGraph::User.me(access_token)
  
   # event = me.event!(
   # :name => 'FbGraph test event',
   # :start_time => 1.week.from_now.to_i,
   # :end_time => 2.week.from_now.to_i
  #)
  
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
