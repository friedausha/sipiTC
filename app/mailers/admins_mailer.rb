class AdminsMailer < ApplicationMailer
  default from: 'dummy.frieda@gmail.com'
  def new_reservation_email(laboratory:)
    @laboratory = laboratory
    mail(to: laboratory.email, subject: 'PC Reservation')
  end
end
