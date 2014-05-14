class MusicsController < ApplicationController
    before_action :set_music, only: [:show, :edit, :update, :destroy]

  # GET /musics
  # GET /musics.json
  def index
    @title = "LifeStyle"
    @subtitle = "My LifeStyle"
    @musics = Music.all
  end

  # GET /Musics/1
  # GET /Musics/1.json
  def show
    @title = @music.nom
    @subtitle = @music.nom
  end

  # GET /Musics/new
  def new
    @title = "New Music"
    @subtitle = "Create New Music"
    @music = Music.new
  end

  # GET /Musics/1/edit
  def edit
    @title = "Editing Music"
    @subtitle = "Editing Music..."
  end

  # POST /Musics
  # POST /Musics.json
  def create
    @music = Music.new(music_params)
    if @music.save
      flash[:success] = "Music created."
      redirect_to @music
      # format.html { redirect_to @project, notice: 'Project was successfully created.' }
      # format.json { render action: 'show', status: :created, location: @project }
    else
      flash[:error] = "Music not created."
      render 'new'
      # format.html { render action: 'new' }
      # format.json { render json: @project.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    @music = Music.find(params[:id])
    if @music.update_attributes(music_params)
      redirect_to musics_path
      flash[:success] = "Music Updated."
    else
      @title = "Editing Music..."
      render 'edit'
      flash[:error] = "Music not Updated."
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @music.destroy
    respond_to do |format|
      format.html { redirect_to musics_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_music
      @music = Music.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def music_params
      params.require(:music).permit(:nom, :compositeur, :path, :altimg)
    end
end