class CourseMailer < BaseMailer
  def course_opened(course, student)
    @course = course
    @student = student
    mail to: @student.email,
      subject: "Classtrack: #{@course.title} is open! Grab it while you can!"
  end
end
