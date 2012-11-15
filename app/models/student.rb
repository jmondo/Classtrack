class Student < ActiveRecord::Base
  has_many :subscriptions, dependent: :destroy, inverse_of: :student
  has_many :courses, through: :subscriptions

  attr_accessible :email, :course_tokens

  validates_presence_of :random_string, :email
  validates_format_of :email,
    with: /^[a-zA-Z0-9\_\-]+[a-zA-Z0-9\.\_\-]*@([a-zA-Z0-9\_\-]+\.)+([a-zA-Z]{2,4})$/

  validate :course_tokens_provided, on: :create
  # this should also do it on update, but it could break other things
  # as of right now, user can go to home page, put in email w/ no courses, and get no error

  before_validation :generate_random_string, on: :create

  after_save :send_account_information, if: proc{ |s| s.changed? }

  attr_reader :course_tokens

  def course_tokens=(ids)
    self.course_ids = (self.course_ids + ids.split(',')).uniq
    changed_attributes[:course_tokens] = nil
  end

  def current_courses
    courses.where(semester: self.semester)
  end

  def confirm_random_string(string)
    random_string == string
  end

  protected

  def course_tokens_provided
    if course_ids.empty?
      errors.add(:course_tokens, "can't be blank")
    end
  end

  def generate_random_string
    self.random_string = SecureRandom.hex(10)
  end

  def send_account_information
    StudentMailer.account_information(self).deliver
  end


end
