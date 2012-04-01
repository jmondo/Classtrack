class Subscription < ActiveRecord::Base
  belongs_to :student, inverse_of: :subscriptions
  belongs_to :course

  validates_presence_of :student, inverse_of: :subscriptions
  validates_uniqueness_of :student_id, scope: :course_id

end
