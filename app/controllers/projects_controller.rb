class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [ :show, :update ]

  def index
    @projects = current_user.projects.order(updated_at: :desc)
  end

  def show
    @comment = Comment.new
    @activities = @project.activity_feed.includes(:user, :trackable)
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      # For a new project, we store the initial status change with from_status as nil
      StatusChange.create!(
        project: @project,
        user: current_user,
        from_status: nil,
        to_status: @project.status_before_type_cast  # Get the integer value
      )
      redirect_to @project, notice: "Project was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    old_status = @project.status_before_type_cast  # Get the integer value before change

    if @project.update(project_params)
      if old_status != @project.status_before_type_cast
        StatusChange.create!(
          project: @project,
          user: current_user,
          from_status: old_status,
          to_status: @project.status_before_type_cast  # Get the integer value after change
        )
      end
      redirect_to @project, notice: "Project was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :status)
  end
end
