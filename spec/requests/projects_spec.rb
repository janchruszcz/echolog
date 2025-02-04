require 'rails_helper'

RSpec.describe "Projects", type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }

  before do
    Warden.test_mode!
    login_as(user, scope: :user)
  end

  after do
    Warden.test_reset!
  end

  describe "GET /projects" do
    it "returns http success" do
      get projects_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /projects" do
    let(:valid_attributes) { { project: { name: "New Project", status: "not_started" } } }

    context "with valid parameters" do
      it "creates a new project" do
        expect {
          post projects_path, params: valid_attributes
        }.to change(Project, :count).by(1)
         .and change(StatusChange, :count).by(1)
      end

      it "creates an initial status change" do
        post projects_path, params: valid_attributes
        status_change = StatusChange.last
        expect(status_change.from_status).to be_nil
        expect(status_change.to_status).to eq(Project.statuses[:not_started])
      end
    end

    # context "with invalid parameters" do
    #  it "does not create a project" do
    #    expect {
    #      post projects_path, params: { project: { name: "" } }
    #    }.to change(Project, :count).by(0)
    #  end
    # end
  end

  describe "PATCH /projects/:id" do
    context "with status change" do
      it "creates a status change record" do
        expect {
          patch project_path(project), params: {
            project: { status: "in_progress" }
          }
        }.to change(StatusChange, :count).by(1)
      end

      it "records correct status values" do
        patch project_path(project), params: {
          project: { status: "in_progress" }
        }

        status_change = StatusChange.last
        expect(status_change.from_status).to eq(Project.statuses[:not_started])
        expect(status_change.to_status).to eq(Project.statuses[:in_progress])
      end
    end
  end
end
