class NotificationsController < ApplicationController
  def new
    @notification = Notification.new
    begin
      @group = Group.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to groups_path, notice: "Group is Not Found."
    end
    
    if  @group.present? && @group.owner_id != current_user.id
      redirect_to groups_path, notice: "Oh! You hane No Authority."
    end
  end

  def create
    @notification = Notification.new(notification_params)
    
    if @notification.save
      # メール送信処理（仮）
      group = Group.find(@notification.group_id)
      owner = User.find(group.owner_id)
      users = group.users
      users.each do |user|
        NotificationMailer.send_notification(@notification, user.email, owner).deliver_now
      end
      redirect_to notifications_completed_path(id:  @notification.id)
    else
      render 'new'
    end
  end

  def completed
    @notification = Notification.find(params[:id])
  end

  private

  def notification_params
    params.require(:notification).permit(:title, :body, :group_id)
  end
end
