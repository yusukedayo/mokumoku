# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :follows, :followers]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to events_path, success: 'ユーザー登録が完了しました'
    else
      flash.now[:danger] = 'ユーザー登録に失敗しました'
      render :new
    end
  end

  def show
  end

  def follows
    @users = @user.following_users
  end
  
  # フォロワー一覧
  def followers
    @follower_users = @user.follower_users
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
