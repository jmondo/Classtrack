require 'spec_helper'

describe Semester do
  it { should have_many :courses }
  it { should have_many :subscriptions }

  it { should validate_presence_of :name }
  it { should validate_presence_of :starting }
  it { should validate_presence_of :ending }
  it { should validate_presence_of :xml_url }

  let(:semester) { Factory(:semester) }

  it "finds if semester is active" do
    semester.active?.should be_true
  end

  it "finds active semesters" do
    semester
    Semester.active.should include(semester)
  end

end