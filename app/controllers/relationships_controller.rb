class RelationshipsController < ApplicationController
  before_action :logged_in_user
  
  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    respond_to do |format|
      format.html { redirect_to user }
      format.json { head :no_content }
    end
  end
  
  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
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