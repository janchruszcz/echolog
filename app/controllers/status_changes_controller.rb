class StatusChangesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project

  def create
    @status_change = @project.status_changes.build(status_change_params.merge(user: current_user))

    if @status_change.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @project, notice: "Status was updated." }
      end
    else
      redirect_to @project, alert: "Unable to update status."
    end
  end

  private

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end

  def status_change_params
    params.require(:status_change).permit(:from_status, :to_status)
  end
end
