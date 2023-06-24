class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @chat = Chat.new
    @user = current_user
    @receiver_id = params[:user_id]
    @chats = Chat.between(current_user.id, params[:user_id])
  end

  def create
    @chat = Chat.new(chat_params)
    @chat.sender = current_user
    @user = current_user
    @chats = Chat.between(current_user.id, params[:user_id])
    if @chat.save
      redirect_to chats_path(@chat.receiver)
    else
      render 'index'
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :receiver_id, :sender_id)
  end
end
