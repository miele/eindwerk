class ContactMailer < ActionMailer::Base
  
  default :from => "terrormic@gmail.com"  
  
  def registration_confirmation(contact)
  	@contact = contact 
    mail(:to => contact.email, :subject => "Rails 3 testmail")  
  end  
  
  
end
