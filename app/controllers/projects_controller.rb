class ProjectsController < ApplicationController

  def show
    @project = Project.published.find_by(code: params[:id])

    respond_to do |format|
      format.html { render :show }
      format.json { render json: @project.to_json }
    end
  end

  def select
    @project = Project.published.find_by(code: params[:id])

    if @project
      @project.select_images(params.try(:[], :project).try(:[], :images))
    end

    respond_to do |format|
      format.json { render json: :ok }
    end
  end

end