class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :trackable, polymorphic: true

  # validates :project, presence: true
  # validates :user, presence: true
  # validates :trackable, presence: true
end
