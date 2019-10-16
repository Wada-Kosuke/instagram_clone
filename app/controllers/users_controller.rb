class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def new
    if logged_in?
      @user = current_user
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    else
      @user = User.new
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "アカウント有効化メールを送信しました。"
      redirect_to root_url
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールを変更しました"
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "アカウントを削除しました"
    redirect_to root_url
  end

  def following
    @title = "フォロー中"
    @user  = User.find(params[:id])
    # @users = @user.following.paginate(page: params[:page])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    # @users = @user.followers.paginate(page: params[:page])
    @users = @user.followers
    render 'show_follow'
  end

  private

    def user_params
    params.require(:user).permit(:full_name, :user_name, :email,
                                :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
