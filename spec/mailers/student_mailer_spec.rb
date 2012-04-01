require "spec_helper"

describe StudentMailer do

  let(:student) { Factory(:student) }
  let(:course) { student.courses.first }
  let(:mail) { StudentMailer.account_information(student) }

  it "sends email with current subscription info" do
    mail.from.should eql(["admin@classtrackit.com"])
    mail.to.should eql([student.email])
    mail.subject.should eql("Classtrack: Courses you're tracking")
  end

  it "contains email address and courses being tracked in email" do
    mail.body.should have_content course.name
    mail.body.should have_link "Change tracked courses"
    mail.body.should have_link "home page"
  end

end
