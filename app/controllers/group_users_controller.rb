class GroupUsersController < ApplicationController
  def join
    @group = Group.find(params[:group_id])
    @user = current_user
    @groups = Group.all
    if @group.users.include?(@user)
      # すでにユーザーがグループに参加している場合の処理
      flash[:notice] = "You are already a member of this group."
    else
      # ユーザーを中間テーブルに保存する処理
      @group.users << @user
      flash[:notice] = "You have joined the group successfully."
    end

    redirect_to groups_path
  end
end
