class Api::UsersController < ApplicationController
  include Admin

  before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  def index
    @users = User
      .search(params[:name])
      .older(params[:minage])
      .younger(params[:maxage])

    show_properties(@users)
  end

  # GET /users/1
  def show
    show_properties(@user)
  end

  # POST /users
  def create
    if !User.ip(request.ip).present? || is_admin
      @user = User.new(user_params)
      @user.ip = request.ip

      if @user.save
        render json: @user, except: [:ip], status: :created, location: api_user_url(@user)
      else
        render json: @user.errors, status: :unauthorized
      end

    else
      render json: {error: "You've already created a user"}, status: :unauthorized
    end
  end

  # PATCH/PUT /users/1
  def update
    unless is_admin || @user.ip == request.ip
      render json: {error: "Access denied"}, status: :unauthorized
    else
      if @user.update(user_params)
        show_properties(@user)
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /users/1
  def destroy
    unless is_admin || @user.ip == request.ip
      render json: {error: "Access denied"}, status: :unauthorized
    else
      render json: {response: "User deleted"}
      @user.destroy
    end
  end

  private
    def show_properties (json)
      render json: json, except: [:created_at, :updated_at, :ip] 
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :age)
    end
end
