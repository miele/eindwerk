class ContactMailer < ActionMailer::Base
  
  default :from => "terrormic@gmail.com"  
  
  def registration_confirmation(contact)
  	t = Time.now  
	@datum = t.strftime("%d/%m/%Y") 
  	@contact = contact
    attachments["booking_" + @contact.id.to_s + ".pdf"] = File.read("#{RAILS_ROOT}/public/report/" + "booking_" + @contact.id.to_s + ".pdf")
    mail(:to => contact.email, :subject => "Skarminkels booking" + @contact.id.to_s)  
  end
  
  def feedback_confirmation(contact)
  	@contact = contact
    mail(:to => contact.email, :subject => "Automatische Feedback")  
  end   
  
  
end
