class Course < ActiveRecord::Base
  belongs_to :semester
  has_many :subscriptions, dependent: :destroy
  has_many :students, through: :subscriptions

  validates_presence_of :semester

  def json
    {id: self.id, name: self.name}
  end

  def name
    "#{self.code}-#{self.section} / #{self.title} / #{self.instructors} / #{self.time}"
  end

  def code_section
    "#{self.code}-#{self.section}"
  end

end
