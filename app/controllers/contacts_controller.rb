class ContactsController < ApplicationController

layout 'html5'

	def index_pdf
	@contact = Contact.find(params[:id])
	render :pdf => "my_pdf",:layout => false,:template => '/contacts/index_pdf',:footer => {:center =>
	"Center", :left => "Left", :right => "Right"}
	end

  # GET /contacts
  # GET /contacts.xml
  def index
    @contacts = Contact.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contacts }
    end
  end
  
  def create  
  @contact = Contact.new(params[:contact])  
  
  respond_to do |format|  
    if @contact.save  
      ContactMailer.registration_confirmation(@contact).deliver  
      format.html { redirect_to(@contact, :notice => 'Contact mail was successfully send.') }  
      format.xml  { render :xml => @contact, :status => :created, :location => @contact }  
    else  
      format.html { render :action => "new" }  
      format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }  
    end  
  end  
end  

  # GET /contacts/1
  # GET /contacts/1.xml
  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.xml
  def new
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
  end


  # PUT /contacts/1
  # PUT /contacts/1.xml
  def update
    @contact = Contact.find(params[:id])

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to(@contact, :notice => 'Contact was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.xml
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to(contacts_url) }
      format.xml  { head :ok }
    end
  end
end
