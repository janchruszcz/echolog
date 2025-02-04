FactoryBot.define do
  factory :status_change do
    from_status { Project.statuses[:not_started] }
    to_status { Project.statuses[:in_progress] }
    association :project
    association :user
  end
end
