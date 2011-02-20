ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",  
  :port                 => 587,  
  :domain               => "michielbogaert.be",  
  :user_name            => "terrormic",  
  :password             => "bogaert",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
} 