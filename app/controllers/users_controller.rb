class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :following, :followers, :inbox, :outbox, :feed, :microposts]
  #before_action :correct_user, only: [:edit, :update, :inbox, :outbox, :feed, :microposts]
  before_action :admin_user, only: [:destroy]

  # GET /users
  # GET /users.json
  def index
    if params[:name].blank?
      @users = User.all
    else
      @users = User.where("name LIKE :name", name: "%#{params[:name].strip}%")
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def following
    @users = @user.following
    render :index
  end
  
  def followers
    @users = @user.followers
    render :index
  end
  
  def inbox
    @messages = @user.in_messages
    render template: 'messages/index'
  end
  
  def outbox
    @messages = @user.out_messages
    render template: 'messages/index'
  end
  
  def feed
    @microposts = @user.feed
    render template: 'microposts/index'
  end
  
  def microposts
    @microposts = @user.microposts
    render template: 'microposts/index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    
    def correct_user
      redirect_to root_url unless @user == current_user
    end
    
    def admin_user
      redirect_to root_url unless !!current_user and current_user.admin?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :first_name, :last_name, :email, :password, :password_confirmation)
    end
end
