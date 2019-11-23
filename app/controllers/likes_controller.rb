class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @micropost = Micropost.find(params[:micropost_id])
    unless current_user.liked?(@micropost)
      current_user.like(@micropost)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @micropost = Like.find(params[:id]).micropost
      if current_user.liked?(@micropost)
      current_user.unlike(@micropost)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end
end
