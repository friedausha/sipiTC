require 'sendgrid-ruby'
include SendGrid
class Mailers
  def new_reservation_email(laboratory)
  from = Email.new(email: 'dummy.frieda@gmail.com')
  subject = 'New Reservation'
  to = Email.new(email: 'dummy.frieda@gmail.com')
  content = Content.new(type: 'text/plain', value: 'Hi, #{laboratory}! Ada reservasi baru tuh!')
  mail = Mail.new(from, subject, to, content)
  # puts JSON.pretty_generate(mail.to_json)
  puts mail.to_json

  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'], host: 'https://api.sendgrid.com')
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  end
end
