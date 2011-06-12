class ContactMailer < ActionMailer::Base

  @data = ConfigKeys.find(1)
  @mail = @data.booking_mail
  
  default :from => @mail  
  
  def registration_confirmation(contact)
  	t = Time.now  
	@datum = t.strftime("%d/%m/%Y") 
  	@contact = contact
    attachments["booking_" + @contact.id.to_s + ".pdf"] = File.read("#{RAILS_ROOT}/public/report/" + "booking_" + @contact.id.to_s + ".pdf")
    mail(:to => contact.email, :subject => "Skarminkels booking" + @contact.id.to_s)  
  end
  
  def feedback_confirmation(contact)
  	@contact = contact
  	 @data = ConfigKeys.find(1)
  	@mail = @data.booking_mail
    mail(:to => @mail, :subject => "Automatische Feedback")  
  end   
  
  
end
