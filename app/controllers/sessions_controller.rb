class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    respond_to do |format|
      if @user
        if @user.authenticate(params[:session][:password])
          log_in @user
          params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
          format.html { redirect_back_or user_path(@user) }
          format.json { redirect_back_or user_path(@user, format: :json) }
        else
          flash.now[:danger] = 'Invalid email/password combination'
          format.html { render :new }
          format.json { render json: 'INVALID' }
        end
      else
        flash.now[:danger] = 'Invalid email/password combination'
        format.html { render :new }
        format.json { render json: 'NEW USER' }
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end