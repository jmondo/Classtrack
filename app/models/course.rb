class Course < ActiveRecord::Base
  belongs_to :semester
  has_many :subscriptions, dependent: :destroy
  has_many :students, through: :subscriptions

  validates_presence_of :semester

  before_update :send_mail_if_just_opened

  def json
    {id: self.id, name: self.name}
  end

  def name
    "#{self.code}-#{self.section} / #{self.title} / #{self.instructors} / #{self.time}"
  end

  def code_section
    "#{self.code}-#{self.section}"
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
