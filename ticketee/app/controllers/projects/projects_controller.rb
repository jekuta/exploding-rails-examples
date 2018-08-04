module Projects
  class ProjectsController < ApplicationController
    def new
      @project = Projects::Project.new
    end

    def create
      transaction = Projects::Create.new

      transaction.(project_params) do |result|
        result.success do |project|
          flash[:notice] = "Project has been created."
          redirect_to project
        end

        result.failure :validate do |errors|
          @project = Projects::Project.new(project_params)
          @errors = errors
          flash.now[:alert] = "Project could not be created."
          render :new
        end
      end
    end

    def index
      @projects = repo.all
    end

    def show
      @project = repo.by_id(params[:id])
    end

    private

    def project_params
      params.require(:project).permit(:name).to_h.symbolize_keys
    end

    def repo
      ProjectRepository.new(ROM.env)
    end
  end
end
