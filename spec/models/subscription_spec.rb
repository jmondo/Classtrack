require 'spec_helper'

describe Subscription do
  subject { Factory(:subscription) }
  it { should belong_to :student }
  it { should belong_to :course }

  it { should validate_uniqueness_of(:student_id).scoped_to(:course_id)}

end
