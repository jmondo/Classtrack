require 'spec_helper'

describe Scraper do

  describe "normal semester case" do
    let!(:semester) { Factory(:semester) }
    let(:course) { Factory(:course, semester: semester, title: "bogus class", code: "ACC1300", section: "01", enrolled: 36, cap: 37) }

    let(:past_semester) { Factory(:semester, ending: Time.now - 1.hour) }
    let(:past_course) { Factory(:course, semester: past_semester, code: "ACC1300", section: "01", title: "bogus class") }

    it "records timestamp for last enrollment scrape" do
      semester.last_enrollment_scraped_at.should be_nil
      Scraper.scrape_enrollments
      semester.reload.last_enrollment_scraped_at.should be_within(2.seconds).of(Time.now)
    end

    it "records timestamp for last information scrape" do
      semester.last_information_scraped_at.should be_nil
      Scraper.scrape_information
      semester.reload.last_information_scraped_at.should be_within(2.seconds).of(Time.now)
    end

    it "updates course enrollment for enrollment scrape" do
      course
      Scraper.scrape_enrollments
      course.reload.enrolled.should eql(38)
      course.cap.should eql(38)
      course.title.should eql("bogus class") # should not change
    end

    it "updates course information for information scrape" do
      course
      Scraper.scrape_information
      course.reload.title.should eql("INTRO TO FINANCIAL ACCOUNTING")
      course.time.should eql("MW     8:00AM- 9:15AM")
      course.instructors.should eql("Bowman, Richard")
      course.cap.should eql(37) # should not change
    end

    it "adds new courses that it finds" do
      Scraper.scrape_information
      Course.count.should eql(3)
      course = Course.first
      course.title.should eql("INTRO TO FINANCIAL ACCOUNTING")
      course.time.should eql("MW     8:00AM- 9:15AM")
      course.instructors.should eql("Bowman, Richard")
      course.enrolled.should eql(38)
      course.cap.should eql(38)
      course.semester.should eql(semester)
    end

    it "does not scrape inactive semesters" do
      Scraper.scrape_information
      past_course.reload.title.should eql("bogus class")
    end
  end

  describe "broken semester config" do
    let!(:broken_semester) { Factory(:semester, xml_url: "malformedurl") }
    let!(:semester) { Factory(:semester) }
    it "does not break with one malformed url semester" do
      Scraper.scrape_enrollments
      broken_semester.reload.last_enrollment_scraped_at.should be_nil
      semester.reload.last_enrollment_scraped_at.should be_present
    end

  end

end
