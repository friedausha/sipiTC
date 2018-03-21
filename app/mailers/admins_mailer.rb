class AdminsMailer < ApplicationMailer
  default from: 'dummy.frieda@gmail.com'
  def new_reservation_email(admin:)
    @admin = admin
    mail(to: admin.email, subject: 'PC Reservation')
  end
end
