FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "Project #{n}" }
    status { :not_started }
    association :user

    trait :with_comments do
      after(:create) do |project|
        create_list(:comment, 2, project: project, user: project.user)
      end
    end

    trait :with_status_changes do
      after(:create) do |project|
        create(:status_change,
          project: project,
          user: project.user,
          from_status: nil,
          to_status: Project.statuses[:not_started]
        )
      end
    end
  end
end
