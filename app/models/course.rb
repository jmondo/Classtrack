class Course < ActiveRecord::Base
  belongs_to :semester
  has_many :subscriptions, dependent: :destroy
  has_many :students, through: :subscriptions

  validates_presence_of :semester

  before_update :send_mail_if_just_opened


  def attributes
    {id: self.id, name: self.name}
  end

  def name
    "#{code}-#{section} / #{semester.name} / #{title} / #{instructors} / #{time}"
  end

  def code_section
    "#{code}-#{section}"
  end

  protected

  def send_mail_if_just_opened
    if (enrolled_changed? || cap_changed?) && (enrolled_was >= cap_was) && (enrolled < cap)
      students.each do |student|
        CourseMailer.course_opened(self, student).deliver
      end
    end
  end

end
