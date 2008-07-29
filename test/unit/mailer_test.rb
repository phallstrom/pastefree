require 'test_helper'

class MailerTest < ActionMailer::TestCase
  tests Mailer
  def test_email_confirmation
    @expected.subject = 'Mailer#email_confirmation'
    @expected.body    = read_fixture('email_confirmation')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Mailer.create_email_confirmation(@expected.date).encoded
  end

end
