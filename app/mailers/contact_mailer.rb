class ContactMailer < ActionMailer::Base
  
  default :from => "terrormic@gmail.com"  
  
  def registration_confirmation(contact)
  	@contact = contact
    attachments["booking_" + @contact.id.to_s + ".pdf"] = File.read("#{RAILS_ROOT}/public/report/" + "booking_" + @contact.id.to_s + ".pdf")
    mail(:to => contact.email, :subject => "Rails 3 testmail")  
  end  
  
  
end
