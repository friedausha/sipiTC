# require "rails_helper"
#
# RSpec.describe AdminsMailer, :type => :mailer do
#   describe "#notifier_email" do
#     let(:laboratory) { create :laboratory }
#     let(:mail) { AdminsMailer.new_reservation_email(laboratory: laboratory) }
#
#     it "renders the headers" do
#       expect(mail.subject).to eq("PC Reservation")
#       expect(mail.to).to eq(["#{laboratory.email}"])
#       expect(mail.from).to eq(["dummy.frieda@gmail.com"])
#     end
#
#     it "renders the body" do
#       name = laboratory.name
#       expect(mail.body.encoded).to match(
#         "Hi, #{name}, ada reservasi baru tuh!")
#     end
#   end
# end
