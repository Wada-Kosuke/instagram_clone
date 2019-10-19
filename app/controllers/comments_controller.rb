class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @comment = current_user.comments.build(comment_params)
    @micropost = Micropost.find_by(id: params[:micropost_id])
    @comment.micropost = @micropost
    if @comment.save
      redirect_to @micropost
    else
      @user = User.find_by(id: @micropost.user_id)
      render 'microposts/show'
    end
  end

  def destroy
    @micropost = @comment.micropost
    @comment.destroy
    redirect_to @micropost
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url unless current_user == @comment.user
    end

end
