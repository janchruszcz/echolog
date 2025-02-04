class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_one :activity, as: :trackable, dependent: :destroy

  # validates :content, presence: true

  after_create :create_activity

  private

  def create_activity
    Activity.create(
      user: user,
      project: project,
      trackable: self
    )
  end
end
