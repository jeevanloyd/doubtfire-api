class TutorProjectStudentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_current_user

  def show
    @student_projects = @user.team_memberships.map{|tm| tm.project }
    @tutor_projects   = Team.where(:user_id => @user.id).map{|team| team.project_template }.uniq

    @student_project  = Project.includes(:project_template).find(params[:project_id])
    @student          = @student_project.user
    @project_template = @student_project.project_template

    authorize! :read, @student_project, :message => "You are not authorised to view Project ##{@student_project.id}"
  end

  def index
  end

  def load_current_user
    @user = current_user
  end
end