require 'spec_helper'

feature 'student signs up' do

  let(:course) { Factory(:course) }
  scenario "student signs up from home page" do
    visit root_path
    fill_in "Email", with: "john@me.com"
    fill_in "Course tokens", with: course.id
    click_button "Start tracking"
    page.should have_content "All signed up! We'll keep track of those for you. If you want to track more classes, just fill out the form again!"
  end
end
