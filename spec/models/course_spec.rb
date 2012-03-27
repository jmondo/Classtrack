require 'spec_helper'

describe Course do
  it { should belong_to :semester }
  it { should have_many :subscriptions }
  it { should have_many :students }
  
  it { should validate_presence_of :semester}
  
  let(:course) { Factory(:course) }
  it "returns element as json-ready hash" do
    course.json.should eql({id: course.id, name: course.name})
  end
  
  it "returns a combination of things for name" do
    course.name.should eql("#{course.code}-#{course.section} / #{course.title} / #{course.instructors} / #{course.time}")
  end
  
  it "returns code section format" do
    course.code_section.should eql("#{course.code}-#{course.section}")
  end
  
end
