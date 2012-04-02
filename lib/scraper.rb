require 'open-uri'
require 'hpricot'

class Scraper
  class << self

    def scrape_enrollments
      scrape_active_semesters_content(:enrollments)
    end

    def scrape_information
      scrape_active_semesters_content(:information)
    end

    protected

    def scrape_active_semesters_content(scrape_type)
      Semester.active.each do |semester|
        scrape_semester_courses(scrape_type, semester)
      end
    end

    def scrape_semester_courses(scrape_type, semester)
      page = Hpricot::XML(open(semester.xml_url))

      (page/'course').each do |item|

        code                  =  (item/'number').inner_text
        section               =  (item/'section').inner_text

        course = find_or_create_course(code, section, semester)
        course_hash = {}

        if course
          if course.new_record? || scrape_type == :enrollments
            course_hash[:cap]          =  (item/'cap').inner_text
            course_hash[:enrolled]     =  (item/'enrolled').inner_text
          end

          if course.new_record? || scrape_type == :information
            course_hash[:title]        =  (item/'title').inner_text
            course_hash[:instructors]  =  (item/'instructors').inner_text
            course_hash[:time]         =  (item/'meeting').inner_text
          end
        end

        update_course_record(course, course_hash)
      end
    end

    def find_or_create_course(code, section, semester)
      courses = Course.where(semester_id: semester, code: code, section: section)
      course = courses.first || courses.build
    end

    def update_course_record(course, course_hash)
      course.assign_attributes(course_hash)
      course.save!
    end
  end
end
