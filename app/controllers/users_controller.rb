class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

   def index
    @title = "Liste des utilisateurs"
    @users = User.paginate(:page => params[:page])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profil actualise."
      redirect_to @user
    else
      @title = "Edition profil"
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @title = @user.nom
  end

  def new
  	@user = User.new
    @title = "Inscription"
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Bienvenue dans l'Application Exemple!"
      redirect_to @user
    else
      @title = "Inscription"
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    @title = "Edition profil"
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Utilisateur supprime."
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:nom, :email, :password, :salt, :encrypted_password)
  end

  def authenticate
    deny_access unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end