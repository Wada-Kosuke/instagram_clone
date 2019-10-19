class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      redirect_to root_url
    else
      @feed_items = []
      @user = current_user
      render 'users/new'
    end
  end

  def show
    @micropost = Micropost.find_by(id: params[:id])
    @user = User.find_by(id: @micropost.user_id)
    @comment = current_user.comments.build
  end

  def destroy
    @micropost.destroy
    redirect_to request.referrer || root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

end
