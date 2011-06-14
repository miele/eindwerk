class ContactsController < ApplicationController

before_filter :authenticate_user!, :except => [:new]

layout 'html5'

	def index_pdf
	t = Time.now  
	@datum = t.strftime("%d/%m/%Y") #t.strftime("%d/%m/%Y %H:%M:%S") 
	@contact = Contact.find(params[:id])
    File.makedirs("#{RAILS_ROOT}/public/report") 
	File.open("#{RAILS_ROOT}/public/report/" + "booking_" + @contact.id.to_s + ".pdf", "w") { |file| file.write(
	render 	:pdf => "my_pdf",
			:layout => false,
			:template => '/contacts/index_pdf',
			:footer => {
						 :center =>"Center",
						 :left => "Left",
						 :right => "Right"} #,
			#:disposition => "attachment" takes care off the download window in your browser
	) }	
	ContactMailer.registration_confirmation(@contact).deliver
	end

  # GET /contacts
  # GET /contacts.xml
  def index
    @contacts = Contact.order("contacts.id DESC").paginate(:per_page => 4,:page => params[:page])

    respond_to do |format|
      format.html { render :layout => 'backend' }
      format.xml  { render :xml => @contacts }
    end
  end
  
  def create  
  @contact = Contact.new(params[:contact])  
  
  respond_to do |format|  
    if @contact.save  
      ContactMailer.feedback_confirmation(@contact).deliver  
      # format.html { redirect_to(@contact, :notice => 'Contact mail was successfully send.') }
      format.html # { redirect_to succes_path }
      format.js  { render :layout => 'html5' } 
      format.xml  { render :xml => @contact, :status => :created, :location => @contact } 
      format.mobile { redirect_to(@contact, :notice => 'Contact mail was successfully send.') }  
    else  
      format.html { render :action => "new" }  
      format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      format.mobile { render :action => "new" }   
    end  
  end  
end 

  # GET /contacts/1
  # GET /contacts/1.xml
  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html { render :layout => 'backend' }
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.xml
  def new
   @footer_tweets = Tweet.order("tweets.created DESC").limit(2)
 @footer_subjects = Subject.order("subjects.id DESC").limit(3)
  @page_title = 'Skarminkels Bookings'
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
      format.js  { render :layout => 'html5' }
      format.xml  { render :xml => @contact }
      format.mobile { render :layout => 'mobile'}
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
    
   respond_to do |format|
format.html  { render :layout => 'backend' }
end
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
  def delete
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to(contacts_url) }
      format.xml  { head :ok }
      format.mobile { render :layout => 'mobile'}
    end
  end
  
  def succes
  end
  
end
