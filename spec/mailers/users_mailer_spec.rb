require "rails_helper"

RSpec.describe UsersMailer, :type => :mailer do
  describe "#reservation_accepted_email" do
    let(:user) { create :user }
    let(:mail) { UsersMailer.reservation_accepted_email(user: user) }

    it "renders the headers" do
      expect(mail.subject).to eq("PC Reservation")
      expect(mail.to).to eq(["#{user.email}"])
      expect(mail.from).to eq(["dummy.frieda@gmail.com"])
    end

    it "renders the body" do
      name = user.name
      expect(mail.body.encoded).to match(
        "Hi, #{name}, selamat permohonan reservasimu diterima!")
    end
  end
end
