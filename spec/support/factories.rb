FactoryGirl.define do
  factory :course do
    sequence(:code)         { |s| "EPS350#{s}" }
    sequence(:title)        { |s| "Best class ever v#{s}" }
    instructors             { ["McKiller", "Bumble Bee", "Braniac", "No-love nerd", "Smellypits", "Mummy"].sample }
    time                    { ["MW 1:40-2:55", "TR 2:00-4:50", "W 1:40-4:50" ].sample }
    sequence(:section)      { |s| s+1 }
    semester
  end

  factory :semester do
    name                    { "Babson Spring" }
    starting                { Time.now - 1.day }
    ending                  { Time.now + 1.month }
    xml_url                 { Rails.root.join('spec', 'support', 'sample.xml').to_s }
  end

  factory :student do
    sequence(:email)        { |s| "user-#{s}@example.com" }
    course_ids              { |s| [Factory(:course).id] }
  end

  factory :subscription do
    course
    student
  end
end
