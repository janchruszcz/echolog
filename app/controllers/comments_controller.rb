class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project

  def create
    @comment = @project.comments.build(comment_params.merge(user: current_user))

    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @project, notice: "Comment was added." }
      end
    else
      redirect_to @project, alert: "Unable to add comment."
    end
  end

  private

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
