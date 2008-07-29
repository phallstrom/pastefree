class Mailer < ActionMailer::Base
  
  def user_confirmation(user)
    subject    'Confirm Your Email Address'
    recipients user.email
    from       ''
    sent_on    Time.now
    
    body       :token => user.generate_token
  end

end
