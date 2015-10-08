class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  
  def show # 追加
    @user = User.find(params[:id])
    @microposts = @user.microposts
    
    @followings = Relationship.select(:followed_id).where(:follower_id => params[:id]).map(&:followed_id)
    @followings_list = User.find(@followings)
    @followers = Relationship.select(:follower_id).where(:followed_id => params[:id]).map(&:follower_id)
    @followers_list = User.find(@followers)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to @user , notice: 'プロフィールを編集しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = Relationship.select(:followed_id).where(:follower_id => params[:id]).map(&:followed_id)
    @followings_list = User.find(@followings)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = Relationship.select(:follower_id).where(:followed_id => params[:id]).map(&:follower_id)
    @followers_list = User.find(@followers)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,:profile,:area)
  end
  def set_user
    @user = User.find(params[:id])
  end
end