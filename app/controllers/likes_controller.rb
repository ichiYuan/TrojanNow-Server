class LikesController < ApplicationController
  before_action :logged_in_user
  
  def create
    current_user.likes.create(micropost_id: params[:micropost_id])
    redirect_to user
  end
  
  def destroy
    current_user.likes.find_by(micropost_id: params[:id]).destroy
    redirect_to user
  end
end