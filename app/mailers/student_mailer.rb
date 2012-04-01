class StudentMailer < BaseMailer
  def account_information(student)
    @student = student
    @courses = @student.courses

    mail to: @student.email,
      subject: "Classtrack: Courses you're tracking"
  end
end
