require 'spec_helper'

describe Course do
  it { should belong_to :semester }
  it { should have_many :subscriptions }
  it { should have_many :students }

  it { should validate_presence_of :semester}

  let(:course) { Factory(:course, enrolled: 10, cap: 10) }
  it "returns element as json-ready hash" do
    course.json.should eql({id: course.id, name: course.name})
  end

  it "returns a combination of things for name" do
    course.name.should eql("#{course.code}-#{course.section} / #{course.title} / #{course.instructors} / #{course.time}")
  end

  it "returns code section format" do
    course.code_section.should eql("#{course.code}-#{course.section}")
  end

  describe "emailing" do
    let!(:subscription) { Factory(:subscription, course: course) }
    let(:deliveries) {  }
    let(:open_course) { Factory(:course, enrolled: 9, cap: 10) }
    before(:each) do
      ActionMailer::Base.deliveries = []
    end

    it "does not send emails when creating a new course" do
      course
      ActionMailer::Base.deliveries.length.should eql(0)
    end

    it "does not send email when class remains full" do
      course.enrolled = 10
      course.cap = 10
      course.save
      ActionMailer::Base.deliveries.length.should eql(0)
    end

    it "does not send when class gets overloaded" do
      course.enrolled = 11
      course.save
      ActionMailer::Base.deliveries.length.should eql(0)
    end

    it "does not send email when both cap and enrolled decrease" do
      course.enrolled = 9
      course.cap = 9
      course.save
      ActionMailer::Base.deliveries.length.should eql(0)
    end

    it "does not send email if course becomes *more* open" do
      open_course.enrolled = 8
      open_course.save
      ActionMailer::Base.deliveries.length.should eql(0)
    end

    it "does not send email on refill" do
      open_course.enrolled = 10
      open_course.save
      ActionMailer::Base.deliveries.length.should eql(0)
    end

    it "does send email when spot opens for first time" do
      course.enrolled = 9
      course.save
      ActionMailer::Base.deliveries.length.should eql(1)
    end
  end

end
