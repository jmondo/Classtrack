class Student < ActiveRecord::Base
  has_many :subscriptions, dependent: :destroy, inverse_of: :student
  has_many :courses, through: :subscriptions

  attr_accessible :email, :course_tokens

  validates_presence_of :random_string, :email

  validate :course_tokens_provided, on: :create
  # this should also do it on update, but it could break other things
  # as of right now, user can go to home page, put in email w/ no courses, and get no error

  before_validation :generate_random_string, on: :create

  attr_accessor :is_student


  attr_reader :course_tokens

  def course_tokens=(ids)
    # raise self.course_ids.inspect
    # raise self.course_ids.inspect # + ids.split(','))
    self.course_ids = (self.course_ids + ids.split(',')).uniq
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

end
