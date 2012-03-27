class Semester < ActiveRecord::Base
  has_many :courses, dependent: :destroy
  has_many :subscriptions, through: :courses
  
  validates_presence_of :name, :starting, :ending, :xml_url
  
  is_sluggable :to_label, history: false, sync: false
  
  def active?
    starting < Time.now && ending > Time.now
  end
  
  def self.active
    where("starting < ? and ending > ?", Time.now, Time.now)
  end

  def to_label
    name
  end
  

end
