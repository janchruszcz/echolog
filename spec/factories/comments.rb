FactoryBot.define do
  factory :comment do
    sequence(:content) { |n| "Comment content #{n}" }
    association :project
    association :user
  end
end
