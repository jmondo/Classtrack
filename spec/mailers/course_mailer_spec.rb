require "spec_helper"

describe CourseMailer do

  let(:student) { Factory(:student) }
  let(:course) { student.courses.first }
  let(:mail) { CourseMailer.course_opened(course, student) }

  include EmailSpec::Helpers

  it "sends email with alert that course is open" do
    mail.from.should eql(["admin@classtrackit.com"])
    mail.to.should eql([student.email])
    mail.subject.should eql("Classtrack: #{course.title} is open! Grab it while you can!")
    EmailSpec::EmailViewer.save_and_open_email(mail)
  end
end
