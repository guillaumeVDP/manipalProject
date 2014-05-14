class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :show, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :show, :update]
  before_filter :admin_user,   :only => [:index]

   def index
    @title = "Users"
    @subtitle = "List of all users"
    @users = User.all
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
    @title = @user.nom
    @subtitle = "Profile"
    @user = User.find(params[:id])
  end

  def new
    @title = "Signup"
    @subtitle = "Sign Up"
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Bienvenue dans l'Application Exemple!"
      redirect_to @user
    else
      @title = "Signup"
      render 'new'
    end
  end

  def edit
    @title = "Profil's Edition"
    @subtitle = "Edition of the Profile"
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted successfully"
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
    redirect_to(root_path) unless (current_user?(@user) || current_user.admin?)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end