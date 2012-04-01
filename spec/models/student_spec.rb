require 'spec_helper'

describe Student do
  it { should have_many :subscriptions }
  it { should have_many :courses }

  it { should allow_mass_assignment_of :email }
  it { should allow_mass_assignment_of :course_tokens }

  # it { should validate_presence_of :random_string }
  it { should validate_presence_of :email }

  let(:student) { Factory(:student) }
  let(:no_token_student) { Student.new({email: "fakeemail@ghadf.com"}) }
  let(:course) { Factory(:course) }
  let(:second_course) { Factory(:course) }
  let(:subscription) { Factory(:subscription, student: student, course: course) }

  it "confirms random string" do
    student.confirm_random_string(student.random_string).should be_true
  end

  it "requires that course tokens are present on create" do
    no_token_student.course_ids.should be_empty
    no_token_student.valid?.should be_false
  end

  it "sets course ids when course tokens are provided" do
    no_token_student.course_tokens = "#{course.id}, #{second_course.id}"
    no_token_student.course_ids.should eql([course.id, second_course.id])
  end

  it "records record change when course tokens are provided" do
    no_token_student.changed_attributes.clear
    no_token_student.changed?.should be_false
    no_token_student.course_tokens = "#{course.id}, #{second_course.id}"
    no_token_student.changed?.should be_true
  end

  it "adds to course ids when course tokens are provided" do
    no_token_student.course_ids = course.id
    no_token_student.course_tokens = "#{second_course.id}"
    no_token_student.course_ids.should eql([course.id, second_course.id])
  end

  it "generates a random string" do
    student.random_string.should be_present
  end

  describe "email" do

    before(:each) do
      student
      ActionMailer::Base.deliveries = []
    end

    it "sends email when course tokens are provided (student create)" do
      no_token_student.course_tokens = "#{course.id}, #{second_course.id}"
      no_token_student.save
      ActionMailer::Base.deliveries.first.subject.should eql("Classtrack: Courses you're tracking")
    end

    it "sends email when course tokens are changed" do
      student.course_tokens = "#{course.id}"
      student.save
      ActionMailer::Base.deliveries.first.subject.should eql("Classtrack: Courses you're tracking")
    end

    it "sends email when email is updated" do
      student.email = "bosu@shf.com"
      student.save
      ActionMailer::Base.deliveries.first.subject.should eql("Classtrack: Courses you're tracking")
    end

    it "does not send email if no attributes change" do
      student.save
      ActionMailer::Base.deliveries.should be_empty
    end
  end

end
