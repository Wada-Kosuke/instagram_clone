class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :new]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      redirect_to root_url
    else
      if params[:micropost][:picture].blank?
        flash[:danger] = "画像を選択してください"
      elsif params[:micropost][:content].length > 140
        flash[:danger] = "コメントは140文字以内です"
      end
      redirect_to root_url
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

  def new
    @micropost  = current_user.microposts.build
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
