require 'spec_helper'

feature 'student edits subscriptions' do

  before(:each) do
    ActionMailer::Base.deliveries = []
  end

  let!(:student) { Factory(:student) }

  include EmailSpec::Helpers

  scenario "student cannot change info without email link" do
    visit student_path(student)
    page.should have_content "Access Denied"
  end

  scenario "student untracks a course" do
    open_last_email
    visit_in_email "Change tracked courses"
    click_button "Stop tracking"
    page.should have_content "You are no longer tracking"
    click_link "home page"
  end

end
