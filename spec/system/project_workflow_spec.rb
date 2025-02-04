require 'rails_helper'

RSpec.describe "Project Workflow", type: :system do
  let(:user) { create(:user) }

  before do
    driven_by(:selenium_chrome_headless)
    login_as(user, scope: :user)
  end

  it "allows creating a project" do
    visit root_path
    click_link "New Project"

    fill_in "Name", with: "Test Project"
    select "Not started", from: "Status"
    click_button "Create Project"

    expect(page).to have_content("Project was successfully created")
    expect(page).to have_content("Test Project")
  end

  it "allows adding comments to a project" do
    project = create(:project, user: user)
    visit project_path(project)

    fill_in "comment_content", with: "Test comment"
    click_button "Post"

    expect(page).to have_content("Comment was added")
    expect(page).to have_content("Test comment")
  end

  it "allows updating a project status" do
    project = create(:project, user: user)
    visit project_path(project)
    select "In progress", from: "project_status"
    click_button "Update"
    expect(page).to have_content("Project was successfully updated")
  end
end
