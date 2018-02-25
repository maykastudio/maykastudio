class ProjectsController < ApplicationController

  before_action :find_project
  after_action :store_visit, only: [:show]

  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @project.to_json }
    end
  end

  def select
    if @project
      @project.select_images(params.try(:[], :project).try(:[], :images))
    end

    respond_to do |format|
      format.json { render json: :ok }
    end
  end

  private

  def find_project
    @project = Project.published.find_by(code: params[:id])
  end

  def store_visit
    if @project
      @project.views.create(user_id: current_user.try(:id), session: request.session.id, user_agent: request.user_agent)
    end
  end

end