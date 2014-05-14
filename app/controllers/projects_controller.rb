class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @title = "Projects"
    @subtitle = "My Projects"
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @title = @project.title
    @subtitle = @project.title
  end

  # GET /projects/new
  def new
    @title = "New Project"
    @subtitle = "Create New Project"
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
    @title = "Editing Project"
    @subtitle = "Editing Project..."
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:success] = "Project created."
      redirect_to @project
      # format.html { redirect_to @project, notice: 'Project was successfully created.' }
      # format.json { render action: 'show', status: :created, location: @project }
    else
      flash[:error] = "Project not created."
      # format.html { render action: 'new' }
      # format.json { render json: @project.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      redirect_to projects_path
      flash[:success] = "Project Updated."
    else
      @title = "Editing Project..."
      render 'edit'
      flash[:error] = "Project not Updated."
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title, :length, :picture, :picture_detail, :content)
    end
end
