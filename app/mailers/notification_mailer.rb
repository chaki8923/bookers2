class NotificationMailer < ApplicationMailer
  def send_notification(notification, mail = nil, owner)
    @notification = notification
    mail(to: mail, subject: 'イベント通知', from: owner.email)
  end
  
end
