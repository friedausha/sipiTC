class UsersMailer < ApplicationMailer
  def reservation_accepted_email(user:)
    @user = user
    mail(to: user.email, subject: 'PC Reservation')
  end
end
