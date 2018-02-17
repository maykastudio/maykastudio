class Manage::ProjectsController < Manage::ApplicationController
  load_and_authorize_resource
  inherit_resources

  actions :all, except: :index

  def index
    @projects = current_user.projects
  end

  protected

  def permitted_params
    { project: params.fetch(:project, {}).permit(:title, :published, :download_count) }
  end

  private

  def begin_of_association_chain
    current_user
  end
end