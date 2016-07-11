class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    @users = User.all.order(created_at: :asc)
    authorize User
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new(user_params)
    authorize @user

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Usuário foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    respond_to do |format|
      if @user.update_with_password(user_params)
        format.html { redirect_to @user, notice: 'Usuário foi atualizado com sucesso.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_role
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attribute(:role, secure_params[:role])
      redirect_to users_path, :notice => "Usuário atualizado."
    else
      redirect_to users_path, :alert => "Não é possível atualizar o Usuário."
    end
  end


  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "Usuário foi excluído com sucesso"
  end

  private

  def secure_params
    params.require(:user).permit(:role)
  end

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :company,
      :password_confirmation,:current_password, :role)
  end

end
