require 'spec_helper'

feature 'student_adds_courses_on_homepage' do

  let(:course) { Factory(:course) }

  describe "new sign up" do
    scenario "student signs up from home page" do
      visit root_path
      fill_in "Email", with: "john@me.com"
      fill_in "Course tokens", with: course.id
      click_button "Start tracking"
      page.should have_content "All signed up! We'll keep track of those for you. If you want to track more classes, just fill out the form again!"

      student = Student.first
      student.email.should eql("john@me.com")
      student.courses.count.should eql(1)
      student.courses.last.should eql(course)
    end
  end

  describe "returning student" do

    before(:each) do
      ActionMailer::Base.deliveries = []
    end

    let!(:student) { Factory(:student, email: "john@me.com") }
    scenario "student visits homepage and signs up again" do
      visit root_path
      fill_in "Email", with: "john@me.com"
      fill_in "Course tokens", with: course.id
      click_button "Start tracking"
      page.should have_content "We know you! We'll keep track of those for you too."

      student = Student.first
      student.email.should eql("john@me.com")
      student.courses.count.should eql(2)
      student.courses.last.should eql(course)
    end

  end


end
