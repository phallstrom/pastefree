class Mailer < ActionMailer::Base
  
  def user_confirmation(user)
    subject    'PasteFree - Confirm Your Email Address'
    recipients user.email
    from       'Paste Free <pastefree@pjkh.com>'
    sent_on    Time.now
    
    body       :token => user.generate_token
  end

end
