class LikesController < ApplicationController
  before_action :logged_in_user
  
  def create
    current_user.likes.create(micropost_id: params[:micropost_id])
    respond_to do |format|
      format.html { redirect_to user }
      format.json { head :no_content }
    end
  end
  
  def destroy
    current_user.likes.find_by(micropost_id: params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to user }
      format.json { head :no_content }
    end
  end
  
  private
    def logged_in_user
      redirect_to root_url unless logged_in?
    end
end