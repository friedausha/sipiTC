# Preview all emails at http://localhost:3000/rails/mailers/admins_mailer
class AdminsMailerPreview < ActionMailer::Preview
  def notifier_email_preview
    AdminsMailer.notifier_email(laboratory: Laboratory)
  end
end
