require 'spec_helper'

feature 'student pays for sms' do

  scenario "student gets instructions after paying" do
    visit sms_path(payment_conf: '3scj7is')
    page.should have_content 'Thanks for paying for SMS alerts!'
    visit sms_path
    page.should have_content 'Thanks for paying for SMS alerts!'
  end

  scenario "student gets alert if does not pay" do
    visit sms_path
    page.should_not have_content 'Thanks for paying for SMS alerts!'
    page.should have_content "Please don't cheat. You're making your whole semester better for the price of one morning coffee."
  end

end
