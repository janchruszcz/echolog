class Project < ApplicationRecord
  belongs_to :user
  has_many :activities, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :status_changes, dependent: :destroy

  # validates :name, presence: true
  # validates :status, presence: true

  enum :status, { not_started: 0, in_progress: 1, under_review: 2, completed: 3 }

  def activity_feed
    activities.order(created_at: :desc)
  end
end
